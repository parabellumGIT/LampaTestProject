//
//  NewsWithoutImageTableViewCell.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit

class NewsWithoutImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var agoLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configure(with newsItem:NewsItem){
        self.sourceLabel.text = newsItem.link.absoluteString
        self.titleLabel.text = newsItem.name
        self.agoLabel.text = newsItem.updatedAt
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
