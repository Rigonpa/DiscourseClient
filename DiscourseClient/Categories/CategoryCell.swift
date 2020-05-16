//
//  CategoryCell.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 25/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    static let cellIdentifier: String = String(describing: CategoryCell.self)
    var viewModel: CategoriesCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.textLabelName
        }
    }
}
