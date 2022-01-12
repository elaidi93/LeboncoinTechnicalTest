//
//  ProductWorker.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 09/01/2022.
//

import Foundation
import Combine

class ProductWorker {
    
    private var observer: AnyCancellable?
    let passthrough = PassthroughSubject<[ProductViewModel]?, Never>()
    
    func fetchProducts() {
        
        guard let productUrl = URL(string: Constants.products_url) else {
            return
        }
        observer = RequestManager.shared.get([ProductResponse].self, from: productUrl)
            .sink { _ in }
    receiveValue: { result in
        DBProductManager.shared.insert(products: result.value)
        let products = result.value.map({ ProductViewModel(with: $0) })
        self.passthrough.send(products)
    }
    }
}
