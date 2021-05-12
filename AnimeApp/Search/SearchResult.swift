//
//  SearchResult.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 4/27/21.
//

import Foundation

class SearchResult {
    
    var synopsis: String!
    var title: String!
    var imageUrls: [String:Any]
    var backDropImages: [String:Any]
    
    // inside attributes dictionary
    init(data: [String:Any]) {
        title = data["canonicalTitle"] as? String ?? ""
        synopsis = data["synopsis"] as? String ?? ""
        imageUrls = data["posterImage"] as? [String:Any] ?? [:]
        backDropImages = data["coverImage"] as? [String:Any] ?? [:]
    }
    
    /*
    if let backposter = att["coverImage"] as? NSDictionary{
        let backimage = backposter["original"] as! String
        let backUrl = URL(string: backimage)!
        backdropview.af.setImage(withURL: backUrl)
    }
    */
    func getImageUrl() -> URL? {
        //let imageUrlString = imageUrls["original"] as! String
        if let imageUrlString = imageUrls["posterImage"] as? NSDictionary{
            let poster = imageUrlString["original"] as! String
            let imageUrl = URL(string: poster)!
            return imageUrl
        }
        else if let imageUrlString = imageUrls["original"] as? String{
            let imageUrl = URL(string: imageUrlString)
            return imageUrl
        }
        return nil
    }
    
    
    
}

