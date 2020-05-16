//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class TopicDataCell: UITableViewCell {
    static let cellIdentifier: String = String(describing: TopicDataCell.self)
    var viewModel: TopicDataCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            textLabel?.text = viewModel.textLabelText
        }
    }
}
