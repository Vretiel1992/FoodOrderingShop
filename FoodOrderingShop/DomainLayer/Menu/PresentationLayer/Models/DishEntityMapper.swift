import Foundation

final class DishEntityMapper: Mappable {

    func map(_ inputModel: DishEntity) -> DishModel {
        DishModel(id: inputModel.id,
             name: inputModel.name,
             price: inputModel.price,
             weight: inputModel.weight,
             description: inputModel.description,
             imageURL: inputModel.imageURL,
             isFavorite: false,
             inBasket: false,
             tags: inputModel.tegs.map {
            $0 == TagModel.Teg.allMenu.string
            ? TagModel(teg: TagModel.Teg.allMenu, isSelected: false)
            : TagModel(teg: TagModel.Teg.custom($0), isSelected: false)
        })
    }
}
