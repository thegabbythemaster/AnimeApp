//
//  AnimeDetailsViewController.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 3/8/21.
//

import UIKit
import CoreData

class AnimeDetailsViewController: UIViewController {

    @IBOutlet weak var backdropview: UIImageView!
    @IBOutlet weak var posterview: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var synopsislabel: UILabel!
    
    var managedObjectContext: NSManagedObjectContext! //need
    
    var animeTitle: String!
    var synopsis: String!
    var backDrop: String?
    var poster: String?
    
    
    @IBAction func AddFav(_ sender: Any) {
        guard let mainView = navigationController?.parent?.view else { return }
        let hudView = HudView.hud(inView: mainView, animated: true)
        hudView.text = "Added"
          afterDelay(2) {
            hudView.hide()
          }
        //MARK: poster image help
        //let urlString = getImage(anime: anime as NSDictionary)
        CoreDataHelper.save(name: animeTitle, synopsis: synopsis, poster: poster ?? "", backDrop: backDrop ?? "")//this helper function saves to the coredata

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        titlelabel.text = animeTitle
        
        if let poster = poster{
            let posterUrl = URL(string: poster)!
            posterview.loadImage(url: posterUrl)
        }
        if let backDrop = backDrop{
            let backUrl = URL(string: backDrop)!
            backdropview.loadImage(url: backUrl)
        }
        synopsislabel.text = synopsis
        
        
    }
    func getImage(anime: NSDictionary)-> String{
        let att = anime["attributes"] as! NSDictionary
        let poster = att["posterImage"] as! NSDictionary
        let urlString = poster["medium"] as! String
        
        return urlString
    }

}
