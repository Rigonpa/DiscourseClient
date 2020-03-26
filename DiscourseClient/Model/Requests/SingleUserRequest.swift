//
//  SingleUserRequest.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class SingleUserRequest: APIRequest {
    
    let username: String
    
    init(username: String) {
        self.username = username
    }

    typealias Response = SingleUserResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/users/\(username).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
}
