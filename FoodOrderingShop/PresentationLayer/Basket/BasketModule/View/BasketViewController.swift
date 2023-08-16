//
//  BasketViewController.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import UIKit
import SnapKit

protocol BasketViewProtocol: AnyObject {
    func update(with data: [BasketTableViewCell.Model])
}

final class BasketViewController: UIViewController {

    // MARK: - Types

    private enum Constants {
        // Numerical
        static let defaultRowHeight: CGFloat = 78

        // Reuse Identifiers
        static let basketCellIdentifier = "basketCellIdentifier"
    }

    // MARK: - Public Properties

    var presenter: BasketPresenterProtocol?

    // MARK: - Private Properties

    private var dishes: [BasketTableViewCell.Model] = []

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
            BasketTableViewCell.self,
            forCellReuseIdentifier: Constants.basketCellIdentifier
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
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - BasketViewProtocol

extension BasketViewController: BasketViewProtocol {
    func update(with data: [BasketTableViewCell.Model]) {
        dishes = data
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.basketCellIdentifier,
            for: indexPath
        ) as? BasketTableViewCell else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AppConstants.Strings.defaultCellIdentifier,
                for: indexPath
            )
            return cell
        }

        if indexPath.row < dishes.count {
            let dish = dishes[indexPath.row]
            cell.configure(with: dish)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.defaultRowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
