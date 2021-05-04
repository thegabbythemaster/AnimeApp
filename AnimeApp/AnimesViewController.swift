//
//  AnimesViewController.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 2/25/21.
//

import UIKit
import AlamofireImage
import CoreData

class AnimesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    
    
    var animes = [[String:Any]]()
//    var animes = [Anime]()
    var numAnime = 0
    var managedObjectContext: NSManagedObjectContext!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadAnime()
    }


 
    func loadAnime(){
        let url = URL(string: "https://kitsu.io/api/edge/anime?page[limit]=20&page[offset]=\(numAnime)")!
        print(url)
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
       // This will run when the network request returns
       if let error = error {
          print(error.localizedDescription)
       } else if let data = data {
          let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
        //THIS WAS CHANGED DATA FROM RESULTS
        self.animes += dataDictionary["data"] as! [[String:Any]]
//        for animeData in dataDictionary {
//            let anime = Anime(data: animeData)
//            self.animes.append(anime)
//        }
        //print(self.animes)
        self.tableView.reloadData()
       }
    }
    task.resume()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == animes.count {
             numAnime = numAnime + 20
             loadAnime()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeCell") as! AnimeCell
        
        let anime = animes[indexPath.row]
        let att = anime["attributes"] as! NSDictionary
        let title = att["canonicalTitle"] as! String
        
        //to get summary
        let synopsis = att["synopsis"] as! String
        let poster = att["posterImage"] as! NSDictionary
        let posterimage = poster["medium"] as! String
        let posterUrl = URL(string: posterimage)!
        
        cell.sumLabel.text = synopsis
        cell.posterView.af.setImage(withURL: posterUrl)
        
        
        cell.titleLabel.text = title
        
        return cell
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //find selected anime
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let anime = animes[indexPath.row]
        //pass the selected movie to the details view controller
        
        let detailsViewController = segue.destination as! AnimeDetailsViewController
        detailsViewController.anime = anime
        
        tableView.deselectRow(at: indexPath, animated: true)
        //MARK: for fav
         if segue.identifier == "TagFav" {
            let controller = segue.destination as! FavAnimeViewController
            controller.managedObjectContext = managedObjectContext

          }

    }

}

//make a sep. view controller that has the categories where the user selects it, makes a new api call, parse the new response and itll display on the home screen when the user goes back
//bookmark tab have a bookmark button at the synosipis page.
//LOOK AT LOCATION APP TO STORE ALL THE BOOKMARKS IN TEXTBOOK 
