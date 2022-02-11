//
//  UserModel.swift
//  IngeniousLabAssessment
//
//  Created by Ban Er Win on 11/02/2022.
//

import Foundation
import ObjectMapper

class GetUserModel: Mappable {
    var responseKey: [GetUserList]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        responseKey <- map["responseKey"]
    }
    
}

class GetUserList : Mappable {
    var avatar : String?
    var name : String?
    var phone : String?
    var isActive : Bool?
    var id : Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        avatar <- map["avatar"]
        name <- map["name"]
        phone <- map["phone"]
        isActive <- map["isActive"]
        id <- map["id"]
        
    }
    
}




