//
//  AnimeDetailsViewController.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 3/8/21.
//

import UIKit
import AlamofireImage
import CoreData

class AnimeDetailsViewController: UIViewController {

    @IBOutlet weak var backdropview: UIImageView!
    @IBOutlet weak var posterview: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var synopsislabel: UILabel!
    var anime: [String:Any]!
    var managedObjectContext: NSManagedObjectContext!
    
    
    @IBAction func AddFav(_ sender: Any) {
        guard let mainView = navigationController?.parent?.view else { return }
        let hudView = HudView.hud(inView: mainView, animated: true)
        hudView.text = "Added"
          afterDelay(2) {
            hudView.hide()
          }
        //MARK: poster image help
        let urlString = getImage(anime: anime as NSDictionary)
        CoreDataHelper.save(name: titlelabel.text!, synopsis: synopsislabel.text!, poster: urlString)

    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let att = anime["attributes"] as! NSDictionary
        let posterimage = getImage(anime: anime as NSDictionary)
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
    func getImage(anime: NSDictionary)-> String{
        let att = anime["attributes"] as! NSDictionary
        let poster = att["posterImage"] as! NSDictionary
        let urlString = poster["medium"] as! String
        //let posterUrl = URL(string: posterimage)!
        
        return urlString
    }

}
