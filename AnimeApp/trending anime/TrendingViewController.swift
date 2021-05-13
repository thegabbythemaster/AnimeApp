//
//  TrendingViewController.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 5/4/21.
//

import UIKit
import CoreData

class TrendingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    
    var animes = [[String:Any]]()
    var managedObjectContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadTrending()
    }
    
    func loadTrending(){
        let url = URL(string: "https://kitsu.io/api/edge/trending/anime")!
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //find selected anime
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let anime = animes[indexPath.row]
        //pass the selected movie to the details view controller
        
        let detailsViewController = segue.destination as! AnimeDetailsViewController
        let att = anime["attributes"] as! NSDictionary
        let title = att["canonicalTitle"] as! String
        
        //to get summary
        let synopsis = att["synopsis"] as! String
        let poster = att["posterImage"] as? NSDictionary ?? [:]
        let posterimage = poster["medium"] as? String
        let backDropImages = att["coverImage"] as? NSDictionary ?? [:]
        let backDrop = backDropImages["original"] as? String
        
        detailsViewController.synopsis = synopsis
        detailsViewController.poster = posterimage
        detailsViewController.animeTitle = title
        detailsViewController.backDrop = backDrop
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        //MARK: for fav
         if segue.identifier == "TagFav" {
            let controller = segue.destination as! FavAnimeViewController
            controller.managedObjectContext = managedObjectContext

          }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell") as! TrendingCell
        
        let anime = animes[indexPath.row]
        let att = anime["attributes"] as! NSDictionary
        let title = att["canonicalTitle"] as! String
        
        //to get summary
        let synopsis = att["synopsis"] as! String
        let poster = att["posterImage"] as! NSDictionary
        let posterimage = poster["medium"] as! String
        let posterUrl = URL(string: posterimage)!
        
        cell.TSynopsisLabel.text = synopsis
        cell.TPosterView.af.setImage(withURL: posterUrl)
        
        
        cell.TTitleLabel.text = title
        
        return cell
    }
    

}
