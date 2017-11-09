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
    
}
