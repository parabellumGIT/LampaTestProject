//
//  TopNewsTableViewCell.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
import ImageSlideshow
import SDWebImage

class TopNewsTableViewCell: UITableViewCell {
    var imageURLs:[URL] = []{
        didSet{
            let imageSource = imageURLs.map { SDWebImageSource(urlString:$0.absoluteString)!}
            self.slider.pageControl.numberOfPages = imageURLs.count
            self.slider.setImageInputs(imageSource)
        }
    }
    
    @IBOutlet weak var agoLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var slider: ImageSlideshow!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
