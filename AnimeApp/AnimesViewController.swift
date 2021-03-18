//
//  AnimesViewController.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 2/25/21.
//

import UIKit
import AlamofireImage

class AnimesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{ //deleted UISearchBarDelegate
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var animes = [[String:Any]]()
    var numAnime = 0
    var filteredData: [[String:Any]] = [] //for search bar

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self //search bar
        filteredData = animes //search bar
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
        //print(self.animes)
        self.tableView.reloadData()
        
        //print(dataDictionary)

          // TODO: Get the array of animes
          // TODO: Store the movies in a property to use elsewhere
          // TODO: Reload your table view data
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
    }
    //MARK: search bar section HELP NEEDED HERE
    
    // This method updates filteredData based on the text in the Search Box
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        // When there is no text, filteredData is the same as the original data
//        // When user has entered text into the search box
//        // Use the filter method to iterate over all items in the data array
//        // For each item, return true if the item should be included and false if the
//        // item should NOT be included
//
//        //MARK: fourth app first chapter
//        filteredData = searchText.isEmpty ? animes : animes.filter { (item: String) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
//
//        tableView.reloadData()
//    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }
}
extension AnimesViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("The search is: \(searchBar.text!)")
    }
}
//make a sep. view controller that has the categories where the user selects it, makes a new api call, parse the new response and itll display on the home screen when the user goes back
//bookmark tab have a bookmark button at the synosipis page.
//LOOK AT LOCATION APP TO STORE ALL THE BOOKMARKS IN TEXTBOOK 
