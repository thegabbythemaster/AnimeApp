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
        load()
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
        //let atts = favAnime["attributes"] as! NSDictionary
        cell.favtitleLabel.text = favAnime.value(forKeyPath: "title") as? String
        cell.favsumLabel.text = favAnime.value(forKeyPath: "synopsis") as? String
        //let synopsis = atts["synopsis"] as! String
        //let poster = atts["posterImage"] as! NSDictionary
        //let posterimage = poster["medium"] as! String
        //let posterUrl = URL(string: posterimage)!
        
        //cell.favsumLabel.text = synopsis
        //cell.favposterView.af.setImage(withURL: posterUrl)
        
        return cell
    }
    
}
