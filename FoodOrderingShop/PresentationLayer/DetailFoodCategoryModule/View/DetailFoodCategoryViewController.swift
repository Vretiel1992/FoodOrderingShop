//
//  DetailFoodCategoryViewController.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 05.07.2023.
//

import UIKit
import SnapKit

protocol DetailFoodCategoryViewProtocol: AnyObject {
    func failure(error: String)
}

class DetailFoodCategoryViewController: UIViewController {

    // MARK: - Public Properties

    var presenter: DetailFoodCategoryPresenterProtocol?

    // MARK: - Private Properties

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
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
        return collectionView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    // MARK: - Private Methods

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }

    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        title = presenter?.giveFoodCategoryData().name
        let imageButton = UIButton(type: .custom)
        imageButton.setImage(Const.Images.userPhoto, for: .normal)
        imageButton.isUserInteractionEnabled = false
        let barButtonItem = UIBarButtonItem(customView: imageButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }

    private func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(
                UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            )
        }
    }
}

// MARK: - UICollectionViewCompositionalLayout

extension DetailFoodCategoryViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
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
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0)
                section.interGroupSpacing = 8
                return section
            } else {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .estimated(109),
                        heightDimension: .estimated(144)
                    )
                )

                let verticalGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(self.collectionView.bounds.width),
                        heightDimension: .estimated(144)
                    ),
                    subitem: item,
                    count: 3
                )
                verticalGroup.interItemSpacing = .fixed(8)

                let nestedGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .estimated(self.collectionView.bounds.width),
                        heightDimension: .estimated(618)
                    ),
                    subitem: verticalGroup,
                    count: 4
                )
                nestedGroup.interItemSpacing = .fixed(14)

                let section = NSCollectionLayoutSection(group: nestedGroup)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//                section.interGroupSpacing = 12
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
            return Teg.allCases.count
        case 1:
            return presenter?.giveFoodCategoryData().dishes?.count ?? 0
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
            let dishTagName = Teg.allCases[indexPath.row].rawValue
            item.configure(text: dishTagName)
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
            if let dish = presenter?.giveFoodCategoryData().dishes?[indexPath.row] {
                item.setupName(dish.name)
                let urlToImage = dish.imageURL
                presenter?.giveImageData(url: urlToImage) { data in
                    guard let imageData = data else { return }
                    item.setupImage(UIImage(data: imageData))
                }
            }
            return item
        }
    }
}

// MARK: - UICollectionViewDelegate

extension DetailFoodCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = collectionView.cellForItem(at: indexPath) as? DishTagCollectionViewCell {
            item.toggleSelection()
        }
        #warning("обратиться к презентеру")
//        presenter?.didTapItem(indexPath: indexPath)
    }
}

// MARK: - DetailFoodCategoryViewProtocol

extension DetailFoodCategoryViewController: DetailFoodCategoryViewProtocol {
    func failure(error: String) {
        print(error)
    }
}
