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
    
    
    override func viewDidLoad() { //loads only once
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
            cell.favposterView.loadImage(url: posterUrl)

        }
        
        return cell
    }
  
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //find selected anime
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let anime = favorites[indexPath.row] 
        //pass the selected movie to the details view controller
        

        let detailsViewController = segue.destination as! AnimeDetailsViewController
        detailsViewController.animeTitle = anime.value(forKey: "title") as? String
        detailsViewController.poster = anime.value(forKey: "poster") as? String
        detailsViewController.synopsis = anime.value(forKey: "synopsis") as? String
        detailsViewController.backDrop = anime.value(forKey: "backDrop") as? String
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        //MARK: for fav
         if segue.identifier == "TagFav" {
            let controller = segue.destination as! FavAnimeViewController
            controller.managedObjectContext = managedObjectContext

          }

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
