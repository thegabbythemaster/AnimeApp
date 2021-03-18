//
//  AnimeDetailsViewController.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 3/8/21.
//

import UIKit
import AlamofireImage

class AnimeDetailsViewController: UIViewController {

    @IBOutlet weak var backdropview: UIImageView!
    @IBOutlet weak var posterview: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var synopsislabel: UILabel!
    
    var anime: [String:Any]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let att = anime["attributes"] as! NSDictionary
        let poster = att["posterImage"] as! NSDictionary
        let posterimage = poster["medium"] as! String
        let posterUrl = URL(string: posterimage)!
        
        if let backposter = att["coverImage"] as? NSDictionary{
            let backimage = backposter["original"] as! String
            let backUrl = URL(string: backimage)!
            backdropview.af.setImage(withURL: backUrl)
        }

        
        
        titlelabel.text = att["canonicalTitle"] as? String
        
        synopsislabel.text = att["synopsis"] as? String
        posterview.af.setImage(withURL: posterUrl)
        
        
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