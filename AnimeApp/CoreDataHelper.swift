//
//  CoreDataHelper.swift
//  MakeSchoolNotes
//
//  Created by Memo on 7/7/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHelper {
    static func save(name: String, synopsis: String, poster: Data) { //need to add third arg. poster: String
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Favorite",
                                   in: managedContext)!
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      // 3
      person.setValue(name, forKeyPath: "title")
      person.setValue(synopsis, forKeyPath: "synopsis")
      person.setValue(poster, forKeyPath: "poster")
      // 4
      do {
        try managedContext.save()
        print("saved")
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    
    }

}

