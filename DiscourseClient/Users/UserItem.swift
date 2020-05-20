//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 25/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserItem: UICollectionViewCell {
    static let cellIdentifier: String = String(describing: UserItem.self)
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 40
        iv.layer.borderWidth = 1
        iv.alpha = 0
        iv.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .avatar
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var viewModel: UsersItemViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            // First time:
            setupUI()
            viewModel.viewDelegate = self

            // All dequeues after first time:
            userNameLabel.text = viewModel.user.username
            guard let avatarImage = viewModel.avatarImage else { return }
            profileImageView.alpha = 1
            profileImageView.image = avatarImage
        }
    }
    
    private func setupUI() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 9),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

extension UserItem: UserViewItemDelegate {
    func userImageFetched() {
        guard let viewModel = viewModel else { return }
        
        self.userNameLabel.text = viewModel.user.username
        guard let avatarImage = viewModel.avatarImage else { return }
        profileImageView.image = avatarImage
        
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            guard let self = self else { return }
            self.profileImageView.alpha = 1
            }, completion: nil)
        self.setNeedsLayout()
    }
}
