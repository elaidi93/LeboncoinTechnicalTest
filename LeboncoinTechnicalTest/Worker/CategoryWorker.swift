//
//  CategoryWorker.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 09/01/2022.
//

import Foundation
import Combine

class CategoryWorker {
    
    static let shared = ProductWorker()
    private var observer: AnyCancellable?
    let send = PassthroughSubject<[CategoryResponse], Never>()
    
    func fetchProducts() -> [CategoryResponse]? {
        
        var categories: [CategoryResponse]?
        
        guard let productUrl = URL(string: Constants.categories_url) else {
            return []
        }
        
        observer = RequestManager.shared.get([CategoryResponse].self, from: productUrl)
            .sink { _ in }
    receiveValue: { result in
        categories = result.value
        self.send.send(result.value)
    }
        
        return categories
    }
    
}
