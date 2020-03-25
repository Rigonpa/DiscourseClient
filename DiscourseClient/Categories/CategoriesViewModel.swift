//
//  CategoriesViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol CategoriesCoordinatorDelegate {
    
}

protocol CategoriesViewDelegate {
    func categoriesFetched()
    func errorFetchingCategories()
}

/// ViewModel representando un listado de categorías
class CategoriesViewModel {
    let categoriesDataManager: CategoriesDataManager
    var categories: [Category] = []
    var viewDelegate: CategoriesViewDelegate?
    var coordinatorDelegate: CategoriesCoordinatorDelegate?
    
    init(categoriesDataManager: CategoriesDataManager) {
        self.categoriesDataManager = categoriesDataManager
    }
    
    func viewDidLoad() {
        categoriesDataManager.fetchCategories { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.viewDelegate?.errorFetchingCategories()
            case .success(let categoriesResponse):
                for each in 0...categoriesResponse.categoryList.categories.count - 1 {
                    self.categories.append(categoriesResponse.categoryList.categories[each])
                }
                self.viewDelegate?.categoriesFetched()
            }
        }
    }
    
    func didSelectRow(indexPath: Int) {
        
    }
    
    func sections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return categories.count
    }
    
    func setCellForRow(indexPath: Int) -> String {
        return categories[indexPath].name
    }
    
}
