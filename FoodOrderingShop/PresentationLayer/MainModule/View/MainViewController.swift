//
//  MainViewController.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import UIKit
import SnapKit

protocol MainViewProtocol: AnyObject {
    func update()
    func failure(error: String)
    func updateLocationLabel(text: String)
    func showLocationAccessDeniedAlert()
}

class MainViewController: UIViewController {

    // MARK: - Public Properties

    var presenter: MainPresenterProtocol?

    // MARK: - Private Properties

    private var foodCategoryImage: UIImage?
    private let topMainView = TopMainView()
    private let loadingView = LoadingView()

    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.didTapUpdateViewButton = { [weak self] in
            guard let self = self else { return }
            self.loadingView.show()
            self.presenter?.viewDidLoad()
        }
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 156
        tableView.separatorStyle = .none
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: Const.Strings.defaultCellIdentifier
        )
        tableView.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: Const.Strings.mainCellIdentifier
        )
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureNavigationBar()
        setupConstraints()
        loadingView.show()
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    // MARK: - Private Methods

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(topMainView)
        view.addSubview(tableView)
        view.addSubview(loadingView)
        view.addSubview(errorView)
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = Const.Strings.empty
    }

    private func hideNavigationBar() {
        navigationController?.navigationBar.isHidden.toggle()
    }

    private func setupConstraints() {
        topMainView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topMainView.snp.bottom)
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        loadingView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(160)
        }
        errorView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(50)
            make.centerY.equalTo(view)
        }
    }
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {

    func update() {
        loadingView.hide()
        tableView.reloadData()
        errorView.isHidden = true
        topMainView.isHidden = false
        tableView.isHidden = false
        tabBarController?.tabBar.isHidden = false
    }

    func failure(error: String) {
        errorView.updateErrorTextLabel(text: error)
        loadingView.hide()
        errorView.isHidden = false
        topMainView.isHidden = true
        tableView.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }

    func showLocationAccessDeniedAlert() {
        let alert = UIAlertController(
            title: Const.Strings.locationAlertTitle,
            message: Const.Strings.locationAlertMessage,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: Const.Strings.settingButton,
            style: .default
        ) { _ in
            guard let settingsURL = URL(
                string: UIApplication.openSettingsURLString
            ) else { return }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        })
        alert.addAction(UIAlertAction(
            title: Const.Strings.cancelButton,
            style: .cancel
        ))
        present(alert, animated: true)
    }

    func updateLocationLabel(text: String) {
        topMainView.updateLocationLabel(text: text)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.giveFoodCategoriesData().count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Const.Strings.mainCellIdentifier,
            for: indexPath
        ) as? MainTableViewCell else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Const.Strings.defaultCellIdentifier,
                for: indexPath
            )
            return cell
        }
        let foodCategories = presenter?.giveFoodCategoriesData() ?? []
        if let urlToImage = foodCategories[indexPath.row].imageURL {
            presenter?.giveImageData(url: urlToImage) { data in
                guard let imageData = data else { return }
                cell.setupImage(UIImage(data: imageData))
            }
        }
        var categoryName = foodCategories[indexPath.row].name
        if indexPath.row == 0 {
            if let range = categoryName.range(of: " ") {
                let firstWord = categoryName.prefix(upTo: range.lowerBound)
                let remainingText = categoryName.suffix(from: range.upperBound)
                let labelText = "\(firstWord)\n\(remainingText)"
                categoryName = labelText
            }
        }
        cell.setupText(categoryName)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        156
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTapFoodCategory(index: indexPath.row)
        #warning("убрать")
        if let foodCategories = presenter?.giveFoodCategoriesData() {
            let foodCategory = foodCategories[indexPath.row]
            let detailFoodCategoryVC = Assembly().createDetailFoodCategoryModule(foodCategory: foodCategory)
            navigationController?.pushViewController(detailFoodCategoryVC, animated: true)
        }
    }
}
