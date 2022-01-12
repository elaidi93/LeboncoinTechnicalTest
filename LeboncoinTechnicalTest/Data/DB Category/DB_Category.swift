//
//  DB_Category.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 10/01/2022.
//
//

import Foundation
import CoreData

@objc(DB_Category)
public class DB_Category: NSManagedObject {
    
}

extension DB_Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DB_Category> {
        return NSFetchRequest<DB_Category>(entityName: "DB_Category")
    }

    @NSManaged public var a_id: Int64
    @NSManaged public var a_name: String?

}

extension DB_Category : Identifiable {

}
