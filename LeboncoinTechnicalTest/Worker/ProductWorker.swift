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
    let passthrough = PassthroughSubject<[ProductViewModel], Never>()
    
    func fetchProducts() -> [ProductViewModel]? {
        
        guard let productUrl = URL(string: Constants.products_url) else {
            return []
        }
        var products = [ProductViewModel]()
        observer = RequestManager.shared.get([ProductResponse].self, from: productUrl)
            .sink { _ in }
    receiveValue: { result in
        products = result.value.map({ ProductViewModel(with: $0) })
        self.passthrough.send(products)
    }
        
        return products
    }
    
}
