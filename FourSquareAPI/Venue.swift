//
//  Restaurant.swift
//  FourSquareAPI
//
//  Created by mahmoud khudairi on 4/25/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

import Foundation
class Venue{
    var name : String = ""
    var id : String = ""
    var address : String = ""
     var city : String = ""
    var phone :String = ""
    var url : String = ""
    var catName : String = ""
    init(dict : [String : Any]){
        
        name = dict["name"] as! String ?? ""
        id = dict["id"] as! String ?? ""
        if let location = dict["location"] as? [String:Any] {
            address = location["address"] as? String ?? ""
            city = location["city"] as? String ?? ""
        }
        if let contact = dict["contact"] as? [String:Any] {
            phone = contact["phone"] as? String ?? ""
        }
        url = dict["url"] as? String ?? ""
        if let categories = dict["categories"] as? [[String:Any]] {
            for catrgory in categories{
            
            catName = catrgory["name"] as? String ?? ""
            
        }
    }
}
}
