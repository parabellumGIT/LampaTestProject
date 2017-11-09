//
//  NewsFeedViewModel.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
func getItemSource(url:URL)->String{
    return url.host!
}
func formatDate(dateString:String) -> String{
   // 2017-11-09T13:48:06.718Z
    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale // save locale temporarily
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = dateFormatter.date(from: dateString)!
    dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
    dateFormatter.locale = tempLocale // reset the locale
    return dateFormatter.string(from: date)
}
class NewsFeedViewModel: NSObject {
    var items = [NewsFeedViewModelItem]()
    init(news:[NewsItem]){
        
        //MARK: - TOP NEWS
        let topNews = news.filter{$0.top == true}
        print("TOP - \(topNews.count)")
        if topNews.count != 0{
            let topItem = TopNewsViewModelImageItem(with: topNews)
        items.append(topItem)
        }
        
        //MARK: WithImage
        let newsWithImage = news.filter{($0.cover != nil && $0.top == false)}
        print("WithImage - \(newsWithImage.count)")
        for newsItem in newsWithImage{
            let item = WithImageViewModelItem(titleName: newsItem.name, source: getItemSource(url:newsItem.link), ago: formatDate(dateString: newsItem.createdAt), cover: newsItem.cover!)
            items.append(item)
        }
        
        //MARK: NoImage
        let newsWithoutImage = news.filter{($0.cover == nil && $0.top == false)}
        print("WithoutImage - \(newsWithoutImage.count)")
        for newsItem in newsWithoutImage{
            
            let item = NoImageViewModelItem(titleName: newsItem.name, source: getItemSource(url: newsItem.link), ago: formatDate(dateString: newsItem.createdAt))
            items.append(item)
            
        }
        print("ALL ITEMS - \(items.count)")
    }
    
    
    
}
