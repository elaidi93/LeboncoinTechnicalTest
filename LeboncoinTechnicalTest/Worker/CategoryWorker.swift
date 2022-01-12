//
//  CategoryWorker.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 09/01/2022.
//

import Foundation
import Combine

class CategoryWorker {
    
    private var observer: AnyCancellable?
    let passthrough = PassthroughSubject<[CategoryViewModel]?, Never>()
    
    func fetchCategories() {
        
        guard let categoriesUrl = URL(string: Constants.categories_url) else {
            return
        }
        observer = RequestManager.shared.get([CategoryResponse].self, from: categoriesUrl)
            .sink { _ in }
    receiveValue: { result in
        DBCategoryManager.shared.insert(categories: result.value)
        let categories = result.value.map({ CategoryViewModel(with: $0) })
        self.passthrough.send(categories)
    }
    }
}
