//
//  WelcomeCell.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 16/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class WelcomeCell: UITableViewCell {
    
    static let cellIdentifier: String = String(describing: WelcomeCell.self)
    
    lazy var orangePopUp: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.tangerine.withAlphaComponent(0.2).cgColor
        view.backgroundColor = .tangerine
        return view
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Welcome to eh.ho", comment: "")
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    lazy var pinView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        guard let pinImage = UIImage(named: "oin") else { fatalError() }
        iv.image = pinImage
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = NSMutableAttributedString(attributedString: "Discourse Setup The first paragraph of this pinned topic...")
        label.text = NSLocalizedString("Discourse Setup The first paragraph of this pinned topic...", comment: "")
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()

    var viewModel: WelcomeCellViewModel? {
        didSet {
            contentView.backgroundColor = .black
            
            setupUI()
        }
    }
    
    private func setupUI() {
        contentView.addSubview(orangePopUp)
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(pinView)
        
        NSLayoutConstraint.activate([
            orangePopUp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            orangePopUp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            orangePopUp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            orangePopUp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
        ])
        
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: orangePopUp.leadingAnchor, constant: 18),
            welcomeLabel.topAnchor.constraint(equalTo: orangePopUp.topAnchor, constant: 9),
            welcomeLabel.widthAnchor.constraint(equalToConstant: 279),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 28),
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: orangePopUp.leadingAnchor, constant: 18),
            messageLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 6),
            messageLabel.widthAnchor.constraint(equalToConstant: 252),
            messageLabel.heightAnchor.constraint(equalToConstant: 53),
        ])
        
        NSLayoutConstraint.activate([
            pinView.trailingAnchor.constraint(equalTo: orangePopUp.trailingAnchor, constant: -15),
            pinView.topAnchor.constraint(equalTo: orangePopUp.topAnchor, constant: 11),
            pinView.widthAnchor.constraint(equalToConstant: 22),
            pinView.heightAnchor.constraint(equalToConstant: 34),
        ])
    }
    
}
