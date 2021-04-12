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
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let managedContext = CoreDataHelper.appDelegate.persistentContainer.viewContext
    
    static //need to add third arg. poster: String
    
    let entity =
        NSEntityDescription.entity(forEntityName: "Favorite",
                                   in: managedContext)!
    
    
    static func save(name: String, synopsis: String, poster: String) {
        // insert anime
        let anime = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        // set values for anime object
        anime.setValue(name, forKeyPath: "title")
        anime.setValue(synopsis, forKeyPath: "synopsis")
        anime.setValue(poster, forKeyPath: "poster")
        
        // save
        do {
            try managedContext.save()
            print("saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    static func delete(anime: NSManagedObject) {
        // fetch anime
        
        // Fetch animes
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        // fetch specific favorite anime
        // make sure that we delete the corrrct anime
        // by querying the title
        let title = anime.value(forKeyPath: "title") as! NSString
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let toDelete = result[0]
            managedContext.delete(toDelete)
            try managedContext.save()
            print("removed anime succesfully")
        } catch {
            print(error)
        }
        
        
        
        // remove anime
        
    }
    
}

