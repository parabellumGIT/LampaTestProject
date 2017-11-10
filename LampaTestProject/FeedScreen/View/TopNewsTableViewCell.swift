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
    var item:NewsFeedViewModelItem?{
        didSet{
            guard let item = item as? TopNewsViewModelImageItem else{
                return
            }
            self.topNews = item.topNews
            self.imageURLs = item.topNews.map{ item -> URL in
                    return item.cover!
            }
            
        }
    }
    var topNews:[NewsItem]!{
        didSet{
            self.label.text = topNews[0].name
            self.sourceLabel.text = getItemSource(url:topNews[0].link)
            self.agoLabel.text = formatDate(dateString: self.topNews[0].updatedAt)
        }
    }
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
        slider.activityIndicator = DefaultActivityIndicator(style: .gray, color: .red)
        slider.contentScaleMode = .scaleAspectFill
        slider.slideshowInterval = 5
        slider.pageControl.currentPageIndicatorTintColor = UIColor(red: 0, green: 173, blue: 239, alpha: 1)
        slider.currentPageChanged = {index in
            self.label.text = self.topNews[index].name
            self.sourceLabel.text = getItemSource(url:self.topNews[index].link)
            self.agoLabel.text = formatDate(dateString: self.topNews[index].updatedAt)
        }
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        
        // Initialization code
    }
    override func prepareForReuse() {
        slider.pageControl.currentPage = 0
        slider.setCurrentPage(0, animated: false)
        self.label.text = topNews[0].name
        self.sourceLabel.text = getItemSource(url:topNews[0].link)
        self.agoLabel.text = formatDate(dateString: self.topNews[0].updatedAt)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
