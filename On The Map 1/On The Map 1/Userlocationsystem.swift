//
//  StudentInformation.swift
//  On The Map 1
//
//  Created by Manish raj(MR) on 16/12/21.
//

import Foundation

struct Userlocationsystem {
    var firstName: String
    var lastName: String
    var longitude: Double
    var latitude: Double
    var mapString: String
    var mediaURL: String
    var uniqueKey: String
    var objectId: String
    var createdAt: String
    var updatedAt: String
    
    init() {
        self.firstName = ""
        self.lastName = ""
        self.longitude = 0.0
        self.latitude = 0.0
        self.mapString = ""
        self.mediaURL = ""
        self.uniqueKey = ""
        self.objectId = ""
        self.createdAt = ""
        self.updatedAt = ""
    }
    
    init?(json: [String: Any]) {
        self.firstName = json["firstName"]  as! String
        self.lastName  = json["lastName"]   as! String
        self.longitude = json["longitude"] as! Double
        self.latitude  = json["latitude"]   as! Double
        self.mapString = json["mapString"]  as! String
        self.mediaURL  = json["mediaURL"]   as! String
        self.uniqueKey = json["uniqueKey"]  as! String
        self.objectId  = json["objectId"]   as! String
        self.createdAt = json["createdAt"]  as! String
        self.updatedAt = json["updatedAt"]  as! String
    }

}
    

