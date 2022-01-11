//
//  DBCategoryManager.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 11/01/2022.
//

import Foundation

class DBCategoryManager {
    static let shared = DBCategoryManager()
    
    let context = AppDelegate.shared.persistentContainer.viewContext
    
    // Fetch all categories
    func fetch() -> [CategoryViewModel]? {
        guard let categories = try? context.fetch(DB_Category.fetchRequest())
        else { return nil }
        
        return categories.map { category in
            CategoryViewModel(with: category)
        }
    }
    
    // Delete all products
    private func delete() {
        guard let products = try? context.fetch(DB_Category.fetchRequest())
        else { return }
        
        for object in products {
            context.delete(object)
        }
        try? context.save()
    }
    
    // Insert Product
    func insert(categories: [CategoryResponse]) {
        
        delete()
        
        for category in categories {
            
            let dbProduct = DB_Category(context: context)
            
            dbProduct.a_id = Int64(category.id ?? 0)
            dbProduct.a_name = category.name ?? ""
        }
        try? context.save()
    }
}
