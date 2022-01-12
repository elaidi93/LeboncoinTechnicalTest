//
//  DB_Product.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 10/01/2022.
//
//

import Foundation
import CoreData

@objc(DB_Product)
public class DB_Product: NSManagedObject {
    
}

extension DB_Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DB_Product> {
        return NSFetchRequest<DB_Product>(entityName: "DB_Product")
    }

    @NSManaged public var a_id: Int64
    @NSManaged public var a_categoryId: Int64
    @NSManaged public var a_title: String?
    @NSManaged public var a_creationDate: Date?
    @NSManaged public var a_description: String?
    @NSManaged public var a_isUrgent: Bool
    @NSManaged public var a_imagesUrl: Data?
    @NSManaged public var a_price: Float

}

extension DB_Product : Identifiable {
    
}
