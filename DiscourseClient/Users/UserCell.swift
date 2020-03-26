//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 25/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    var viewModel: UsersCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.usernameLabel
            
            if let imageData = viewModel.avatarData {
                imageView?.image = UIImage(data: imageData)
            }
        }
    }
    
}
