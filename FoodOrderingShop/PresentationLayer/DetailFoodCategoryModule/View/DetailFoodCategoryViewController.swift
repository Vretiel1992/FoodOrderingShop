//
//  DetailFoodCategoryViewController.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 05.07.2023.
//

import UIKit
import SnapKit

protocol DetailFoodCategoryViewProtocol: AnyObject {
    func update(
        _ dishTagData: [DishTagCollectionViewCell.Model],
        _ dishesData: [DishCollectionViewCell.Model]
    )
    func update(
        _ itemIndexPaths: (activeItem: IndexPath, currentItem: IndexPath),
        _ sectionIndex: Int,
        _ dishesData: [DishCollectionViewCell.Model]
    )
    func failure(error: String)
}

class DetailFoodCategoryViewController: UIViewController {

    // MARK: - Public Properties

    var presenter: DetailFoodCategoryPresenterProtocol?

    // MARK: - Private Properties

    private var dishTags: [DishTagCollectionViewCell.Model] = []
    private var dishes: [DishCollectionViewCell.Model] = []

    private lazy var topView: TopDetailFoodCategoryView = {
        let view = TopDetailFoodCategoryView()
        view.didTapBackButton = { [weak self] in
            self?.presenter?.didTapBackButton()
        }
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            DishTagCollectionViewCell.self,
            forCellWithReuseIdentifier: Const.Strings.dishTagCellIdentifier
        )
        collectionView.register(
            DishCollectionViewCell.self,
            forCellWithReuseIdentifier: Const.Strings.dishCellIdentifier
        )
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: Const.Strings.defaultCellIdentifier
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
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
        view.addSubview(topView)
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(57)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - DetailFoodCategoryViewProtocol

extension DetailFoodCategoryViewController: DetailFoodCategoryViewProtocol {
    func update(
        _ dishTagData: [DishTagCollectionViewCell.Model],
        _ dishesData: [DishCollectionViewCell.Model]
    ) {
        dishTags = dishTagData
        dishes = dishesData
        collectionView.reloadData()
    }

    func failure(error: String) {
        print(error)
    }

    func update(
        _ itemIndexPaths: (activeItem: IndexPath, currentItem: IndexPath),
        _ sectionIndex: Int,
        _ dishesData: [DishCollectionViewCell.Model]
    ) {
        if let item = collectionView.cellForItem(at: itemIndexPaths.activeItem) as? DishTagCollectionViewCell {
            item.toggleSelection()
        }

        if let item = collectionView.cellForItem(at: itemIndexPaths.currentItem) as? DishTagCollectionViewCell {
            item.toggleSelection()
        }
        dishes = dishesData
        collectionView.reloadSections(
            IndexSet(integer: sectionIndex)
        )
    }
}

// MARK: - UICollectionViewCompositionalLayout

extension DetailFoodCategoryViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _  in
            if sectionIndex == 0 {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .estimated(80),
                        heightDimension: .fractionalHeight(1)
                    )
                )

                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .estimated(450),
                        heightDimension: .absolute(35)
                    ),
                    subitems: [item]
                )

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
                section.interGroupSpacing = 8
                return section
            } else {
                let numberOfItemsInRow: Int = 3

                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(144)
                    )
                )

                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(144)
                    ),
                    subitem: item,
                    count: numberOfItemsInRow
                )
                group.interItemSpacing = .fixed(8)

                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 14
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                return section
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension DetailFoodCategoryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case 0:
            return dishTags.count
        case 1:
            return dishes.count
        default:
            return 0
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        if indexPath.section == 0 {
            guard let item = collectionView.dequeueReusableCell(
                withReuseIdentifier: Const.Strings.dishTagCellIdentifier,
                for: indexPath
            ) as? DishTagCollectionViewCell else {
                let item = collectionView.dequeueReusableCell(
                    withReuseIdentifier: Const.Strings.defaultCellIdentifier,
                    for: indexPath
                )
                return item
            }

            if indexPath.row < dishTags.count {
                let tags = dishTags[indexPath.row]
                item.configure(with: tags)
                if let indexPathOfSelectedItem = presenter?.whichItemToSelect() {
                    if indexPath == indexPathOfSelectedItem {
                        item.toggleSelection()
                    }
                }
            }

            return item
        } else {
            guard let item = collectionView.dequeueReusableCell(
                withReuseIdentifier: Const.Strings.dishCellIdentifier,
                for: indexPath
            ) as? DishCollectionViewCell else {
                let item = collectionView.dequeueReusableCell(
                    withReuseIdentifier: Const.Strings.defaultCellIdentifier,
                    for: indexPath
                )
                return item
            }

            if indexPath.row < dishes.count {
                var dishes = self.dishes[indexPath.row]
                item.configure(with: dishes)

                if let urlToImage = dishes.dishImageURL {
                    presenter?.giveImageData(url: urlToImage) { data in
                        guard let imageData = data else { return }

                        dishes.dishImage = UIImage(data: imageData)
                        item.configure(with: dishes)
                    }
                }
            }

            return item
        }
    }
}

// MARK: - UICollectionViewDelegate

extension DetailFoodCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            presenter?.didTapDishTag(indexPath)
        case 1:
            presenter?.didTapDish(indexPath.row)
        default:
            break
        }
    }
}
