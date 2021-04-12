//
//  FavAnimeViewController.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 3/18/21.
//

import UIKit
import CoreData

class FavAnimeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var favorites = [NSManagedObject]()
    var numAnime = 0
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    //loads every time view appears
    override func viewDidAppear(_ animated: Bool) {
        load()
    }
    
    func load() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        //3
        do {
            favorites = try managedContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "FavTableViewCell") as! FavTableViewCell
        
        
        let favAnime = favorites[indexPath.row]

        cell.favtitleLabel.text = favAnime.value(forKeyPath: "title") as? String
        cell.favsumLabel.text = favAnime.value(forKeyPath: "synopsis") as? String
        if let poster = favAnime.value(forKey: "poster") as? String{
            let posterUrl = URL(string: poster)!
            cell.favposterView.af.setImage(withURL: posterUrl)

        }
        
        return cell
    }
    //MARK: Delete favorite items
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let anime = favorites[indexPath.row]
        
        if editingStyle == .delete {
            CoreDataHelper.delete(anime: anime)
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
