//
//  SearchResultCell.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 4/27/21.
//

import UIKit

class SearchResultCell: UITableViewCell {

    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
          selectedView.backgroundColor = UIColor(named: "SearchBar")?.withAlphaComponent(0.5)
          selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    // MARK: - Helper Methods
    func configure(for result: SearchResult) {
      nameLabel.text = result.title
        
      posterImageView.image = UIImage(systemName: "square")
     // if let smallURL = URL(string: result.imageSmall) {
        //downloadTask = posterImageView.loadImage(url: smallURL)
      //}
    }

}
