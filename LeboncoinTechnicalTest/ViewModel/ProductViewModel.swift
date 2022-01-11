//
//  ProductViewModel.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 10/01/2022.
//

import Foundation

class ProductViewModel {
    
    private(set) var id: Int?
    private(set) var categoryId: Int?
    private(set) var title: String?
    private(set) var creationDate: Date?
    private(set) var description: String?
    private(set) var isUrgent: Bool?
    private(set) var smallImage: String?
    private(set) var thumbImage: String?
    private(set) var price: Float?
    
    init(with product: ProductResponse) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        
        guard let id = product.id,
              let categoryId = product.category_id,
              let title = product.title,
              let date = product.creation_date,
              let creationDate = formatter.date(from: date),
              let description = product.description,
              let isUrgent = product.is_urgent,
              let imagesUrl = product.images_url,
              let smallImage = imagesUrl["small"],
              let thumbImage = imagesUrl["thumb"],
              let price = product.price
        else { return }
        
        self.id = id
        self.categoryId = categoryId
        self.title = title
        self.creationDate = creationDate
        self.description = description
        self.isUrgent = isUrgent
        self.smallImage = smallImage
        self.thumbImage = thumbImage
        self.price = price
    }
    
    init(with dbProduct: DB_Product) {
        id = Int(dbProduct.a_id)
        categoryId = Int(dbProduct.a_categoryId)
        title = dbProduct.a_title
        creationDate = dbProduct.a_creationDate
        description = dbProduct.a_description
        isUrgent = dbProduct.a_isUrgent
        let imagesUrl = try? JSONDecoder().decode([String: String].self, from: dbProduct.a_imagesUrl!)
        smallImage = imagesUrl?["small"]
        thumbImage = imagesUrl?["thumb"]
        price = dbProduct.a_price
    }
    
}
