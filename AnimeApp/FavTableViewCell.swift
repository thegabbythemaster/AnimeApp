//
//  FavTableViewCell.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 3/18/21.
//

import UIKit

class FavTableViewCell: UITableViewCell {

    @IBOutlet weak var favposterView: UIImageView!
    @IBOutlet weak var favtitleLabel: UILabel!
    @IBOutlet weak var favsumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
