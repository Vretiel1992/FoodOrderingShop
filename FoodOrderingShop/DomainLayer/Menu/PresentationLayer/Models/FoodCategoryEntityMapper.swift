import Foundation

final class FoodCategoryEntityMapper: Mappable {

    func map(_ inputModel: FoodCategoryEntity) -> FoodCategoryModel {
        FoodCategoryModel(
            id: inputModel.id,
            name: inputModel.name,
            imageURL: inputModel.imageURL
        )
    }
}
