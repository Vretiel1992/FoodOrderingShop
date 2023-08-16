//
//  MainViewController.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import UIKit
import SnapKit

protocol MainViewProtocol: AnyObject {
    func update(with data: [MainTableViewCell.Model])
    func failure(error: String)
    func updateLocationLabel(text: String)
    func showLocationAccessDeniedAlert()
}

final class MainViewController: UIViewController {

    // MARK: - Types

    private enum Constants {
        // Numerical
        static let defaultRowHeight: CGFloat = 156

        // Reuse Identifiers
        static let mainCellIdentifier = "mainCellIdentifier"
    }

    // MARK: - Public Properties

    var presenter: MainPresenterProtocol?

    // MARK: - Private Properties

    private var categories: [MainTableViewCell.Model] = []
    private var foodCategoryImage: UIImage?
    private let topMainView = TopMainView()
    private let loadingView = LoadingView()

    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.didTapUpdateViewButton = { [weak self] in
            guard let self = self else { return }
            self.loadingView.show()
            self.presenter?.didTapUpdateViewButton()
        }
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = Constants.defaultRowHeight
        tableView.separatorStyle = .none
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: AppConstants.Strings.defaultCellIdentifier
        )
        tableView.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: Constants.mainCellIdentifier
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

    // MARK: - Private Methods

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(topMainView)
        view.addSubview(tableView)
        view.addSubview(loadingView)
        view.addSubview(errorView)
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }

    private func setupConstraints() {
        topMainView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(57)
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

    func update(with data: [MainTableViewCell.Model]) {
        categories = data
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
            title: Strings.MainModule.MainVC.LocationAlert.title,
            message: Strings.MainModule.MainVC.LocationAlert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: Strings.MainModule.MainVC.LocationAlert.SettingButton.title,
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
            title: Strings.MainModule.MainVC.LocationAlert.CancelButton.title,
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
        categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.mainCellIdentifier,
            for: indexPath
        ) as? MainTableViewCell else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AppConstants.Strings.defaultCellIdentifier,
                for: indexPath
            )
            return cell
        }

        if indexPath.row < categories.count {
            let category = categories[indexPath.row]
            cell.configure(with: category)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.defaultRowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTapFoodCategory(index: indexPath.row)
    }
}
