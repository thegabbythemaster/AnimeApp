//
//  SearchViewController.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 4/27/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResults = [SearchResult]()
    var hasSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
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

}
// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
      return .topAttached
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    //instantiate a new String array and replace the contents of searchResults property with it. This is done each time the user performs a search.
      searchResults = []
    if searchBar.text! != "justin bieber" {
      for i in 0...2 {
        //This creates an instance of the SearchResult object and simply puts some fake text into its name and artistName properties.
        let searchResult = SearchResult()
        searchResult.name = String(format: "Fake Result %d for", i)
        searchResult.synopsis = searchBar.text!
        searchResults.append(searchResult)
      }
    }
    hasSearched = true
    tableView.reloadData()
  }
}
// MARK: - Table View Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched {
            return 0
          } else if searchResults.count == 0 {
            return 1
          } else {
            return searchResults.count
          }
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SearchResultCell"
      
        var cell: UITableViewCell! = tableView.dequeueReusableCell(
        withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(
            style: .subtitle, reuseIdentifier: cellIdentifier)
      }
        // New code
        if searchResults.count == 0 {
            cell.textLabel!.text = "Nothing found"
            cell.detailTextLabel!.text = ""
        } else {
            let searchResult = searchResults[indexPath.row]
            cell.textLabel!.text = searchResult.name
            cell.detailTextLabel!.text = searchResult.synopsis
        }
        return cell
    }
    
}
