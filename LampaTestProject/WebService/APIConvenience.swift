//
//  WebServiceConvenience.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//
import Disk
extension WebService{
    //
    //Here we can use some "Expire date" for cache in future..
    //
    func getNews(_ completionHandler: @escaping (_ results:[NewsItem]?, _ error: Error?) -> Void){
        let parameters = [WebService.QueryParameterKeys.Langugage:"en",
                          WebService.QueryParameterKeys.NewsCount:"10",
                          WebService.QueryParameterKeys.Sources:"7,19,13,5,15,16,12,9,10012,10010,10013,10014,10019,10018,10011",
                          WebService.QueryParameterKeys.FeedLineID: "5"]
        if let retrirvedMessage = try? Disk.retrieve("News/news.json", from: .caches, as: [NewsItem].self){
            completionHandler(retrirvedMessage, nil)
        }else{
            let _ = taskForGetMethod(parameters: parameters) { (results, error) in
                if let error = error {
                    completionHandler(nil, error)
                } else {
                    do{
                        let news = try self.decoder.decode([NewsItem].self, from: results!)
                        try Disk.save(news, to: .caches, as: "News/news.json")
                        completionHandler(news, nil)
                    }catch{
                        fatalError("CANT transform data from JSON to NewsItem array")
                    }
                    
                }
            }
        }
    }
}
