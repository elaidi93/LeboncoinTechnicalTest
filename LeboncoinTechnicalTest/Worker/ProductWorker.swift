//
//  ProductWorker.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 09/01/2022.
//

import Foundation
import Combine

class ProductWorker {
    
    static let shared = ProductWorker()
    private var observer: AnyCancellable?
    let send = PassthroughSubject<[ProductResponse], Never>()
    
    func fetchProducts() -> [ProductResponse]? {
        
        var products: [ProductResponse]?
        
        guard let productUrl = URL(string: Constants.products_url) else {
            return []
        }
        
        observer = RequestManager.shared.get([ProductResponse].self, from: productUrl)
            .sink { _ in }
    receiveValue: { result in
        products = result.value
        self.send.send(result.value)
    }
        
        return products
    }
    
}
