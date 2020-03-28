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

            viewModel.viewDelegate = self
            
            
            /* He intentado inicializar celdas con closure en lugar
             de delegation pero no me funciona:
             
             viewModel.imageClosure = { [weak self] () -> Void in
                 guard let self = self else { return }
             
                 self.textLabel?.text = viewModel.usernameLabel
             
                 if let imageData = viewModel.avatarData {
                    self.imageView?.image = UIImage(data: imageData)
                }
             }
             */
            
        }
    }
}

extension UserCell: UserViewCellDelegate {
    func userImageFetched() {
        guard let viewModel = viewModel else { return }
        if let imageData = viewModel.avatarData {
            imageView?.image = UIImage(data: imageData)
        }
        self.setNeedsLayout()
    }
}
