//
//  CategoriesResponse.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 24/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct CategoriesResponse: Codable {
    let categoryList: CategoryList
    
    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

struct CategoryList: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let name: String
}
