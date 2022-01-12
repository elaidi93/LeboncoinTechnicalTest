//
//  DBProductManager.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 11/01/2022.
//

import Foundation

class DBProductManager {
    static let shared = DBProductManager()
    
    let context = AppDelegate.shared.persistentContainer.viewContext
    
    // Fetch all products
    func fetch() -> [ProductViewModel]? {
        guard let products = try? context.fetch(DB_Product.fetchRequest())
        else { return nil }
        
        return products.map { product in
            ProductViewModel(with: product)
        }
        
    }
    
    // Delete all products
    private func delete() {
        guard let products = try? context.fetch(DB_Product.fetchRequest())
        else { return }
        
        for object in products {
            context.delete(object)
        }
        try? context.save()
    }
    
    // Insert Product
    func insert(products: [ProductResponse]) {
        
        delete()
        
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        
        for product in products {
            
            let dbProduct = DB_Product(context: context)
            
            dbProduct.a_id = Int64(product.id ?? 0)
            dbProduct.a_categoryId = Int64(product.category_id ?? 0)
            dbProduct.a_title = product.title
            if let creationDate = formatter.date(from: product.creation_date ?? "") {
                dbProduct.a_creationDate = creationDate
            }
            dbProduct.a_description = product.description ?? ""
            dbProduct.a_isUrgent = product.is_urgent ?? false
            dbProduct.a_imagesUrl = try? JSONEncoder().encode(product.images_url)
            dbProduct.a_price = product.price ?? 0
        }
        try? context.save()
    }
}
