//
//  CategoriesCellViewModel.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 25/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class CategoriesCellViewModel {
    let category: Category
    var textLabelName: String?
    
    init(category: Category) {
        self.category = category
        textLabelName = category.name
    }
}
