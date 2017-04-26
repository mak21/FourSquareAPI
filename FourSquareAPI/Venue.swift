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
    var lat : Double = 0.0
    var lng : Double = 0.0
    var phone :String = ""
    var url : String = ""
    var catName : String = ""
    init(dict : [String : Any]){
        
        name = dict["name"] as? String ?? "Not Available"
        id = dict["id"] as? String ?? ""
        if let location = dict["location"] as? [String:Any] {
            address = location["address"] as? String ?? "Not Available"
            city = location["city"] as? String ?? "Not Available"
            lat = location["lat"] as? Double ?? 0.0
            lng = location["lng"] as? Double ?? 0.0
            
        }
        if let contact = dict["contact"] as? [String:Any] {
            phone = contact["phone"] as? String ?? "Not Available"
        }
        url = dict["url"] as? String ?? "Not Available"
        if let categories = dict["categories"] as? [[String:Any]] {
            for catrgory in categories{
            
            catName = catrgory["name"] as? String ?? "Not Available"
            
        }
    }
}
}
