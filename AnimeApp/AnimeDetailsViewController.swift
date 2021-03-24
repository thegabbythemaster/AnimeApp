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
        CoreDataHelper.save(name: titlelabel.text!, synopsis: synopsislabel.text!)

    }
   
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
