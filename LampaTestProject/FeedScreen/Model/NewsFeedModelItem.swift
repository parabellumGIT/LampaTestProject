//
//  NewsFeedModelItem.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
protocol NewsFeedViewModelItem{
    var type: NewsFeedViewModelItemType {get}
    var date: Date {get set}
}

enum NewsFeedViewModelItemType{
    case topItem
    case withImageItem
    case noImageItem
}


class TopNewsViewModelImageItem: NewsFeedViewModelItem{
    var date: Date = Date()
    
    var type: NewsFeedViewModelItemType{
        return .topItem
    }
    var topNews:[NewsItem]
    init(with topNews:[NewsItem]){
        self.topNews = topNews
    }
}

class WithImageViewModelItem:NewsFeedViewModelItem{
    var date: Date
    
    var type:NewsFeedViewModelItemType{
        return .withImageItem
    }
    var titleName: String
    var source:String
    var ago:String
    var cover:URL
    init(titleName:String,source:String,ago:String,cover:URL,date:Date){
        self.titleName = titleName
        self.source = source
        self.ago = ago
        self.cover = cover
        self.date = date
    }
}

class NoImageViewModelItem:NewsFeedViewModelItem{
    var date: Date
    
    var type:NewsFeedViewModelItemType{
        return .noImageItem
    }
    var titleName: String
    var source:String
    var ago:String
    init(titleName:String,source:String,ago:String,date:Date){
        self.titleName = titleName
        self.source = source
        self.ago = ago
        self.date = date
    }
}
