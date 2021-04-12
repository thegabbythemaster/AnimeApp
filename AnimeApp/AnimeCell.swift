//
//  AnimeCell.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 3/2/21.
//

import UIKit
import AlamofireImage

class AnimeCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    
//    var anime: Anime! {
//        titleLabel.text = anime.title
//        sumLabel.text = anime.summary
//        posterView.af.setImage(withURL: URL(anime.posterURL!))
//        
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
