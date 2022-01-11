//
//  CategoryViewModel.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 11/01/2022.
//

import Foundation

class CategoryViewModel {
    
    private(set) var id: Int?
    private(set) var name: String?
    
    init(with category: CategoryResponse) {
        
        guard let id = category.id,
              let name = category.name
        else { return }
        
        self.id = id
        self.name = name
    }
    
    init(with dbCategory: DB_Category) {
        id = Int(dbCategory.a_id)
        name = dbCategory.a_name
    }
    
}
