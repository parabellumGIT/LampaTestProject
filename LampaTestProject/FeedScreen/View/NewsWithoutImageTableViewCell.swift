//
//  NewsWithoutImageTableViewCell.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit

class NewsWithoutImageTableViewCell: UITableViewCell {
    
    var item:NewsFeedViewModelItem?{
        didSet{
            guard let item = item as? NoImageViewModelItem else{
                return
            }
            self.agoLabel.text = item.ago
            self.titleLabel.text = item.titleName
            self.sourceLabel.text = item.source
            
        }
    }
    @IBOutlet weak var agoLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
