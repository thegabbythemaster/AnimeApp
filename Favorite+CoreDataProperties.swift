//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by Gabby Gonzalez on 3/18/21.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var title: String?
    @NSManaged public var summary: String?

}
