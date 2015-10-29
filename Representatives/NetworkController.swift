//
//  NetworkController.swift
//  Representatives
//
//  Created by Zach Steed on 10/29/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit


class NetworkController {
    
    static func searchRepresentatives(searchString: String, callback: ([Representative]?, NSError?) -> ()) {
        
        let preparedSearchString = searchString.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        let stringUrl = "http://whoismyrepresentative.com/getall_reps_bystate.php?state=\(preparedSearchString)&output=json"
        
        if let url = NSURL(string: stringUrl) {
            
            let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                if let error = error {
                    callback(nil, error)
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                let jsonObject: AnyObject
                
                do {
                    jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                } catch(let error as NSError) {
                    callback(nil, error)
                    return
                }
                
                if let searchObject = jsonObject as? [String: [AnyObject]],
                    let states = searchObject["Search"] {
                        
                        var representativeObjects: [Representative] = []
                        
                        states.forEach({ (jsonRepresentative) -> () in
                            if let representativeObject = Representative(data: jsonRepresentative) {
                                representativeObjects.append(representativeObject)
                            }
                            
                        })
                        
                        callback(representativeObjects, nil)
                        
                        
                } else {
                    
                    callback(nil, nil)
                    
                }
            }
            
            dataTask.resume()
        }
    }
}
    