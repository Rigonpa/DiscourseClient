//
//  CreateTopicRequest.swift
//
//  Created by Ignacio Garcia Sainz on 17/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//  Revisado por Roberto Garrido on 8 de Marzo de 2020
//

import Foundation

struct CreateTopicRequest: APIRequest {
    
    typealias Response = AddNewTopicResponse
    
    let title: String
    let raw: String
    
    init(title: String, raw: String) {
        self.title = title
        self.raw = raw
    }

    
    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/posts.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [
            "title" : "\(title)",
            "raw" : "\(raw)"
//            "raw" : "Image url: \(title)",
//            "topic_slug" : "Image url: \(raw)",
//            "image_url" : "\(imageUrl)",
//            "topic_slug" : "https://ichef.bbci.co.uk/news/410/cpsprodpb/E5F6/production/_96907885_gettyimages-629387256.jpg"
        ]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
