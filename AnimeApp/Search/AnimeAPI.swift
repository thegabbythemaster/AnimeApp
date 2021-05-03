//
//  AnimeAPI.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 5/3/21.
//

import Alamofire


class AnimeApi {
    
    /*
     Searches on anime API and returns an array of search results
     */
    static func search(searchText: String, completion: @escaping ([SearchResult]?) -> Void) {
        let urlString = String(format: "https://kitsu.io/api/edge/anime?filter[text]=\(searchText)")
        
        guard let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            //Invalid URL
            return
        }
        AF.request(urlString).responseJSON() { response in
            

            let data = response.value as! [String:Any]
            let animeDataArray = data["data"] as! [[String:Any]]
            
            var searchResults: [SearchResult] = []
            
            for animeData in animeDataArray {
                let attributes = animeData["attributes"] as! [String:Any]
                let searchResult = SearchResult(data: attributes)
                searchResults.append(searchResult)
            }
            
            return completion(searchResults)
    
        }
        
        
    }
    
    
}
