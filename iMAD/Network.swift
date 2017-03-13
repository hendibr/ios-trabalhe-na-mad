//
//  Network.swift
//  Mad
//
//  Created by hendi on 12/03/17.
//  Copyright © 2017 cuca. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

struct Network {
    
    static func fechRepositories(inPage:Int) {
        
        let urlString = "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=\(inPage)"
        
        Alamofire.request(urlString).responseJSON { response in
            
            if let value = response.result.value {
                
                let json = value as! Dictionary<String, Any>
                let items = json["items"]
                                
                for item in items as! Array<Any> {
                    
                    if let repo = Repo(json:item as! JSON) {
                        repo.save()
                    }
                }
            }
        }
    }
    
    static func fetchPullRequests(for repo:String, from owner:String, completionHandler: @escaping (_ pulls:[Pull]?,_ error: Error?) -> Void) {
        
        let urlString = "https://api.github.com/repos/\(owner)/\(repo)/pulls"

        Alamofire.request(urlString).responseJSON { response in
            
            if let value = response.result.value {
             
                var pulls : [Pull] = []
                
                let json = value as! Array<Any>
                
                for item in json {
                    
                    print(item)
                    
                    if let pull = Pull(json: item as! JSON) {
                        pulls.append(pull)
                        pull.save()
                    }
                }
                
                completionHandler(pulls, nil)
            }
            completionHandler(nil, response.error)
        }
    }
    
    static func downloadPhoto(from url:String, completionHandler: @escaping (_ image:Data?,_ error: Error?) -> Void) {
        
        Alamofire.request(url).responseData { response in
            guard let data = response.result.value else { return }
            completionHandler(data, nil)
        }
    }
}













