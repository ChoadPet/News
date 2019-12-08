//
//  BasicTextTableViewCell.swift
//  WorldwideNews
//
//  Created by pc251 on 04.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import UIKit

class BasicTextTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        selectionStyle = .none
    }
    
    func updateCell(with object: NewsEntity) {
        titleLabel.text = object.title
        descriptionLabel.text = object.articleDescription
        dateLabel.text = object.publishedAt
    }
}
