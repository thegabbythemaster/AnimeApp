//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by Gabby Gonzalez on 3/20/21.
//
//

import Foundation
import CoreData
import UIKit

extension Favorite{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var title: String?
    @NSManaged public var synopsis: String?
    @NSManaged public var poster: Data?
}
