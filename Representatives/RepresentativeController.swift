//
//  RepresentativeController.swift
//  Representatives
//
//  Created by Zach Steed on 10/29/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class RepresentativeController {
    
    static func searchRepsByState(state: String, callback: (representatives: [Representative]) -> Void) {
        
        let url = NetworkController.searchRepresentatives(state) { (<#[Representative]?#>, <#NSError?#>) -> () in
            <#code#>
        }
        
        NetworkController.dataAtURL(url) { (resultData) -> Void in
            guard let representativeData = resultData  else {
                print("NO DATA RETURNED")
                callback(representatives: [])
                return
            }
            
            do {
                let resultsDictionary = try NSJSONSerialization.JSONObjectWithData(representativeData, options: NSJSONReadingOptions.AllowFragments) as! [String : AnyObject]
                
                let representativeDictionaries = resultsDictionary[Representative.kResultsKey] as! [[String : String]]
                
                var arrayOfRepresentativeModelObjects: [Representative] = []
                
                for dictionary in representativeDictionaries {
                    let rep = Representative(jsonDictionary: dictionary)
                    arrayOfRepresentativeModelObjects.append(rep)
                }
                
                callback(representatives: arrayOfRepresentativeModelObjects)
                
            } catch {
                print("Error serializing JSON")
                callback(representatives: [])
                return
            }
        }
    }
}
    