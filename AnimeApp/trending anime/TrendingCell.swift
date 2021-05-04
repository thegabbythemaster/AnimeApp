//
//  TrendingCell.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 5/4/21.
//

import UIKit

class TrendingCell: UITableViewCell {

    @IBOutlet weak var TPosterView: UIImageView!
    @IBOutlet weak var TTitleLabel: UILabel!
    @IBOutlet weak var TSynopsisLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
