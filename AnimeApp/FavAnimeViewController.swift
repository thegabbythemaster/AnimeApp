//
//  FavAnimeViewController.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 3/18/21.
//

import UIKit

class FavAnimeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var animes = [[String:Any]]()
    var numAnime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadAnimes()
        // Do any additional setup after loading the view.
    }
    
    func loadAnimes(){
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "FavTableViewCell") as! FavTableViewCell
        
        let favAnime = animes[indexPath.row]
        let atts = favAnime["attributes"] as! NSDictionary
        let title = atts["canonicalTitle"] as! String
        
        let synopsis = atts["synopsis"] as! String
        let poster = atts["posterImage"] as! NSDictionary
        let posterimage = poster["medium"] as! String
        let posterUrl = URL(string: posterimage)!
        
        cell.favsumLabel.text = synopsis
        cell.favposterView.af.setImage(withURL: posterUrl)
        
        cell.favtitleLabel!.text = title
 
        return cell
    }
}
