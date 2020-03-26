//
//  UpdateUserNameRequest.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class UpdateUserNameRequest: APIRequest {
    
    typealias Response = UpdateUserNameResponse
    
    let username: String
    let newName: String
    
    init(username: String, newName: String) {
        self.username = username
        self.newName = newName
    }
    
    var method: Method {
        return .PUT
    }
    var path: String {
        return "/users/\(username)"
    }
    var parameters: [String : String] {
        return [:]
    }
    var body: [String : Any] {
        return [
            "name" : "\(newName)"
        ]
    }
    var headers: [String : String] {
        return [:]
    }

}
