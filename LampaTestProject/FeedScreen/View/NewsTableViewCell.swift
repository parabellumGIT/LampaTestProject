//
//  NewsTableViewCell.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
import SDWebImage
class NewsTableViewCell: UITableViewCell {
    var item:NewsFeedViewModelItem?{
        didSet{
            guard let item = item as? WithImageViewModelItem else{
                return
            }
            
           self.newsImage.sd_setImage(with: item.cover, completed: nil) 
            self.titleLabel.text = item.titleName
            self.agoLabel.text = item.ago
            self.sourceLabel.text = item.source
        }
        
    }
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var agoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
