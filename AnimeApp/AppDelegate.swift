//
//  AppDelegate.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 2/25/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var managedObjectContext = persistentContainer.viewContext //need
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      print(applicationDocumentsDirectory)
      return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    //for the favorite tab
    lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "MyFav")
      container.loadPersistentStores {_, error in
        if let error = error {
          fatalError("Could not load data store: \(error)")
        }
      }
      return container
    }()
    //need for saving in core data
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
          do {
            try context.save()
          } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
        }
      }

}

