//
//  MainViewController.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import UIKit
import SnapKit

protocol MainViewProtocol: AnyObject {
    func success(dataOfFoodCategories: [FoodСategory])
    func success(imageData: Data)
    func failure(error: String)
    func updateLocationLabel(text: String)
    func showLocationAccessDeniedAlert()
}

class MainViewController: UIViewController {

    // MARK: - Public Properties

    var presenter: MainPresenterProtocol?

    // MARK: - Private Properties

    private var foodCategories: [FoodСategory] = []
    private var foodCategoryImage: UIImage?
    private let topMainView = TopMainView()

    private lazy var errorMainView: ErrorMainView = {
        let view = ErrorMainView()
        view.didTapUpdateViewButton = { [weak self] in
            self?.presenter?.viewDidLoad()
        }
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 148
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
        setupConstraints()
        presenter?.viewDidLoad()
    }

    // MARK: - Private Methods

    private func setupViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        view.addSubview(topMainView)
        view.addSubview(tableView)
        view.addSubview(errorMainView)
    }

    private func setupConstraints() {
        topMainView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topMainView.snp.bottom)
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        errorMainView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(50)
            make.centerY.equalTo(view)
        }
    }
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {

    func success(dataOfFoodCategories: [FoodСategory]) {
        foodCategories = dataOfFoodCategories
        tableView.reloadData()
        errorMainView.isHidden = true
        topMainView.isHidden = false
        tableView.isHidden = false
        tabBarController?.tabBar.isHidden = false
    }

    func success(imageData: Data) {
        self.foodCategoryImage = UIImage(data: imageData)
    }

    func failure(error: String) {
        errorMainView.updateErrorTextLabel(text: error)
        errorMainView.isHidden = false
        topMainView.isHidden = true
        tableView.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }

    func showLocationAccessDeniedAlert() {
        let alert = UIAlertController(
            title: "Доступ к геолокации запрещен",
            message: "Для определения вашего местоположения необходимо включить доступ к геолокации в настройках приложения.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Настройки", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        })
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    func updateLocationLabel(text: String) {
        topMainView.updateLocationLabel(text: text)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodCategories.count
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

    }
}
