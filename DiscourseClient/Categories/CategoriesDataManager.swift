//
//  CategoriesDataManager.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 24/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol CategoriesDataManager {
    func fetchCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ())
}
