//
//  NewsItem.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
struct NewsItem: Decodable {
    let name: String
    let link: URL
    let cover: URL?
    let sourceId: Int
    let top: Bool
    let createdAt: String
    let updatedAt: String
    var date:Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+2:00") //Current time zone
        return dateFormatter.date(from: self.createdAt)!
    }
    
}
