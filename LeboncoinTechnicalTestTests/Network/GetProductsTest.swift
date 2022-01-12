//
//  GetProductsTest.swift
//  LeboncoinTechnicalTestTests
//
//  Created by hamza on 12/01/2022.
//

import XCTest
import Combine
@testable import LeboncoinTechnicalTest

class ProductsRequestTest: XCTestCase {
    private var observer: AnyCancellable?
    func testRoute() {
        XCTAssertEqual("https://raw.githubusercontent.com/leboncoin/paperclip/master/", Constants.rout)
    }
    
    func testModule() {
        XCTAssertEqual("https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json", Constants.products_url)
    }
    
    func testWS() throws {
        let productWorker = ProductWorker()
        productWorker.fetchProducts()
        
        observer = productWorker.passthrough.sink { result in
            let products = try XCTUnwrap(result)
            for product in products {
                XCTAssertNotNil(product.id)
                XCTAssertNotNil(product.categoryId)
                XCTAssertNotNil(product.title)
                XCTAssertNotNil(product.creationDate)
                XCTAssertNotNil(product.description)
                XCTAssertNotNil(product.isUrgent)
                XCTAssertNotNil(product.smallImage)
                XCTAssertNotNil(product.thumbImage)
                XCTAssertNotNil(product.price)
            }
        }
    }
}
