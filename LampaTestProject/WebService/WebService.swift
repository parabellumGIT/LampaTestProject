//
//  WebService.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
import Disk
class WebService:NSObject{
    class func shared() -> WebService{
        struct Singleton{
            static var sharedInstance = WebService()
        }
        return Singleton.sharedInstance
    }
    
    
    //Shared session
    var session = URLSession.shared
    var decoder = JSONDecoder()
    
    func taskForGetMethod(parameters:[String:String], completionHandlerForGet: @escaping(_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask{
        /* 1. Set the parameters */
        
        
        /* 2/3. Build the URL, Configure the request */
        let request = URLRequest(url: URLFromParameters(parameters))
        print(request)
        /* 4. Make the request */
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGet(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
           // self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGet)
            completionHandlerForGet(data, nil)
        }
        /* 7. Start the request */
        task.resume()
        return task
    }
    //MARK: Helpers
   
    
    private func URLFromParameters(_ parameters: [String:String]) -> URL {
        var components = URLComponents()
        components.scheme = WebService.Constants.ApiScheme
        components.host = WebService.Constants.ApiHost
        components.path = WebService.Constants.ApiPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: value)
            components.queryItems!.append(queryItem)
        }
        print(components.url!.absoluteString)
        return components.url!
    }
}


