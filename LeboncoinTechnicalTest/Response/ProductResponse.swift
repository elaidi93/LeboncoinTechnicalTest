//
//  ProductResponse.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 09/01/2022.
//

import Foundation

struct ProductResponse: Codable {
    
    let id: Int
    let category_id: Int
    let title: String
    let creation_date: String
    let description: String
    let is_urgent: Bool
    let images_url: [String: String]
    let price: Float
    
}
