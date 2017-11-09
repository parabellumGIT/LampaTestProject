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
}

enum NewsFeedViewModelItemType{
    case topItem
    case withImageItem
    case noImageItem
}


class TopNewsViewModelImageItem: NewsFeedViewModelItem{
    var type: NewsFeedViewModelItemType{
        return .topItem
    }
    var topNews:[NewsItem]
    init(with topNews:[NewsItem]){
        self.topNews = topNews
    }
    
    
}

class WithImageViewModelItem:NewsFeedViewModelItem{
    var type:NewsFeedViewModelItemType{
        return .withImageItem
    }
    var titleName: String
    var source:String
    var ago:String
    var cover:URL
    init(titleName:String,source:String,ago:String,cover:URL){
        self.titleName = titleName
        self.source = source
        self.ago = ago
        self.cover = cover
    }
}

class NoImageViewModelItem:NewsFeedViewModelItem{
    var type:NewsFeedViewModelItemType{
        return .noImageItem
    }
    var titleName: String
    var source:String
    var ago:String
    init(titleName:String,source:String,ago:String){
        self.titleName = titleName
        self.source = source
        self.ago = ago
    }
}
