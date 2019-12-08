//
//  NewsTableViewCell.swift
//  WorldwideNews
//
//  Created by pc251 on 03.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import UIKit

// TODO: Change to own caching system
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .default
        accessoryType = .disclosureIndicator
        
        newsImageView.layer.cornerRadius = 10
        newsImageView.clipsToBounds = true
    }
    
    func updateCell(with object: NewsEntity) {
        newsTitleLabel.text = object.title
        newsDescriptionLabel.text = object.articleDescription
        
        // :( sorry about that
        // i'll change to own caching if will have time.
        // But at least there is funny pug image
        if let stringURL = object.urlToImage, let url = URL(string: stringURL) {
            newsImageView.kf.setImage(with: url,
                                      placeholder: UIImage(named: "emptyImage"),
                                      options: [.transition(.fade(0.5))])
        }
    }
}
