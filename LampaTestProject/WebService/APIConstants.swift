//
//  APIConstants.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

extension WebService{
    
    struct Constants {
        // MARK: URLs
        static let ApiScheme = "http"
        static let ApiHost = "owledge.ru"
        static let ApiPath = "/api/v1/feedNews"
    }
    
    struct QueryParameterKeys {
        static let Langugage = "lang"
        static let NewsCount = "count"
        static let Sources = "sources"
        static let FeedLineID = "feedLineId"
    }
    
    struct JSONResponseKeys{
        static let Root = "query"
        static let Results = "results"
        static let Rates = "rate"
        static let RateName = "Name"
        static let RateValue = "Ask"
        static let Time = "Time"
    }
    
    
    
}
