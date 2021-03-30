//
//  FavAnimeViewController.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 3/18/21.
//

import UIKit
import CoreData

class FavAnimeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var favorites = [NSManagedObject]()
    var numAnime = 0
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        load()
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
    
    func load() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        //3
        do {
            favorites = try managedContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "FavTableViewCell") as! FavTableViewCell
        
        let favAnime = favorites[indexPath.row]
        //let atts = favAnime["attributes"] as! NSDictionary
        cell.favtitleLabel.text = favAnime.value(forKeyPath: "title") as? String
        cell.favsumLabel.text = favAnime.value(forKeyPath: "synopsis") as? String
        // cell.favposterView = favAnime.value(forKeyPath: "poster") as? String problem here
       
        /*
        if let imageData = favAnime.value(forKeyPath: "poster") as? Data {
            cell.favposterView = posterViewFromImageData(imageData)
        }
        else { cellfavposterView = someDefaultPosterView }
        */
        //cell.favsumLabel.text = synopsis
        //cell.favposterView.af.setImage(withURL: posterUrl)
        
        return cell
    }
/*
//MARK: helper for poster view
extension Data
{
    init<T: NSCoding>(from source: T)
    {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        archiver.encode(source, forKey: "0")
        archiver.finishEncoding()
        
        self = archiver.encodedData
    }
    
    func decode<T:NSCoding>(to type: T.Type) -> T?
    {
        guard let unarchiver = try? NSKeyedUnarchiver(forReadingFrom: self),
              let obj = unarchiver.decodeObject(of: [T.self], forKey: "0")
        else { return nil }
        
        return obj as? T
    }
}
 class UIImageTransformer: NSSecureUnarchiveFromDataTransformer
 {
     public override func transformedValue(_ value: Any?) -> Any? {
         return (value as? Data)?.decode(to: UIImage.self)
     }
     
     public override func reverseTransformedValue(_ value: Any?) -> Any?
     {
         guard let image = value as? UIImage else { return nil }
         return Data(from: image)
     }
 }
 extension NSValueTransformerName
 {
     static var imageToNameTransformer: NSValueTransformerName {
         .init("imageToNameTransformer")
     }
 }
*/
