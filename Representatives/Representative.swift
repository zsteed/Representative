//
//  Representative.swift
//  Representatives
//
//  Created by Zach Steed on 10/29/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class Representative {
    
    var name: String?
    var party: String?
    var state: String?
    var district: String?
    var phone: String?
    var office: String?
    var link: String?
    
    init?(data: AnyObject?) {
        
        guard let data = data as? [String: String] else { return nil }
        
        self.name = data["name"]
        self.party = data["party"]
        self.state = data["state"]
        self.district = data["district"]
        self.phone = data["phone"]
        self.office = data["office"]
        self.link = data["link"]
        
    }
    
}