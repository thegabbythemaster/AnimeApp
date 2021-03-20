//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by Gabby Gonzalez on 3/20/21.
//
//

import Foundation
import CoreData


extension Favorite{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var summary: String?
    @NSManaged public var title: String?

}
