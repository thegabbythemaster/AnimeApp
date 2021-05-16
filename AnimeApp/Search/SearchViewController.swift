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
    var selectedAnime: SearchResult?
    var hasSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        searchBar.becomeFirstResponder()
    }
    
    
    func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.loadingCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.loadingCell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //find selected anime
        
        let anime = selectedAnime!
        //pass the selected movie to the details view controller
        
        let detailsViewController = segue.destination as! AnimeDetailsViewController
        
        detailsViewController.synopsis = anime.synopsis
        detailsViewController.poster = anime.imageUrls["original"] as? String
        detailsViewController.animeTitle = anime.title
        detailsViewController.backDrop = anime.backDropImages["original"] as? String
        //
        
        
        
    }
    
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Whoops...", message: "There was an error accessing the Anime Store. Please try again.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty {
            searchBar.resignFirstResponder()
            print("searching...")
            AnimeApi.search(searchText: searchBar.text!) { results in
                if let results = results {
                    self.searchResults = results
                    print("results:", results)
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
}

struct TableView {
    
    struct CellIdentifiers {
        static let searchResultCell = "SearchResultCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "LoadingCell"
    }
    
}

// MARK: - Table View Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults.count == 0 {
            return 1
        }
        
        return searchResults.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAnime = searchResults[indexPath.row]
        performSegue(withIdentifier: "Details", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchResults.count == 0 {
            return tableView.dequeueReusableCell(
                withIdentifier: TableView.CellIdentifiers.nothingFoundCell, for: indexPath)
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell,for: indexPath) as! SearchResultCell
            
            let searchResult = searchResults[indexPath.row]
            
            if let imageUrl = searchResult.getImageUrl() {
                cell.posterImageView.loadImage(url: imageUrl)
            }
            
            cell.nameLabel.text = searchResult.title
            cell.synopsisLabel.text = searchResult.synopsis
            return cell
        }
    }
}
