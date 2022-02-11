//
//  UserDetails.swift
//  IngeniousLabAssessment
//
//  Created by Ban Er Win on 11/02/2022.
//

import Foundation
import ObjectMapper

class GetUserDetail : Mappable {
    var avatar : String?
    var name : String?
    var phone : String?
    var email : String?
    var description : String?
    var id : Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        avatar <- map["avatar"]
        name <- map["name"]
        phone <- map["phone"]
        email <- map["email"]
        description <- map["description"]
        id <- map["id"]
        
    }
    
}
