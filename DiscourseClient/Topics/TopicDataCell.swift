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
    
    lazy var topicImageView: UIImageView = {
        guard let image = UIImage(named: "charmander") else { fatalError() }
        let iv = UIImageView()
        iv.image = image
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 32
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var topicTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .style27
        label.numberOfLines = 0
        return label
    }()
    
    lazy var firstIconBelow: UIImageView = {
        guard let image = UIImage(named: "icoSmallAnswers") else { fatalError() }
        let iv = UIImageView()
        iv.image = image
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.opacity = 0.7
        return iv
    }()
    
    lazy var firstValueBelow: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .justified
        label.layer.opacity = 0.5
        return label
    }()
    
    lazy var secondIconBelow: UIImageView = {
        guard let image = UIImage(named: "icoViewsSmall") else { fatalError() }
        let iv = UIImageView()
        iv.image = image
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.opacity = 0.7
        return iv
    }()
    
    lazy var secondValueBelow: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .justified
        label.layer.opacity = 0.5
        return label
    }()
    
    lazy var thirdIconBelow: UIImageView = {
        guard let image = UIImage(named: "icoSmallCalendar") else { fatalError() }
        let iv = UIImageView()
        iv.image = image
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.opacity = 0.7
        return iv
    }()
    
    lazy var thirdValueBelow: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .justified
        label.layer.opacity = 0.5
        return label
    }()

    static let cellIdentifier: String = String(describing: TopicDataCell.self)
    var viewModel: TopicDataCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            setupUI()
            topicTitleLabel.text = viewModel.topic.title
            firstValueBelow.text = String(viewModel.topic.postsCount)
            secondValueBelow.text = String(viewModel.topic.views)
            thirdValueBelow.text = viewModel.dateAfterFormatter
            
        }
    }
    
    private func setupUI() {
        contentView.addSubview(topicImageView)
        contentView.addSubview(topicTitleLabel)
        
        contentView.addSubview(firstIconBelow)
        contentView.addSubview(firstValueBelow)
        contentView.addSubview(secondIconBelow)
        contentView.addSubview(secondValueBelow)
        contentView.addSubview(thirdIconBelow)
        contentView.addSubview(thirdValueBelow)

        NSLayoutConstraint.activate([
            topicImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            topicImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            topicImageView.widthAnchor.constraint(equalToConstant: 64),
            topicImageView.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            topicTitleLabel.leadingAnchor.constraint(equalTo: topicImageView.trailingAnchor, constant: 11),
            topicTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            topicTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -59),
            topicTitleLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            firstIconBelow.leadingAnchor.constraint(equalTo: topicImageView.trailingAnchor, constant: 11),
            firstIconBelow.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            firstIconBelow.widthAnchor.constraint(equalToConstant: 17),
            firstIconBelow.heightAnchor.constraint(equalToConstant: 14)
        ])
        
        NSLayoutConstraint.activate([
            firstValueBelow.leadingAnchor.constraint(equalTo: firstIconBelow.trailingAnchor, constant: 5),
            firstValueBelow.centerYAnchor.constraint(equalTo: firstIconBelow.centerYAnchor),
            firstValueBelow.widthAnchor.constraint(equalToConstant: 14),
            firstValueBelow.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            secondIconBelow.leadingAnchor.constraint(equalTo: firstValueBelow.trailingAnchor, constant: 3),
            secondIconBelow.centerYAnchor.constraint(equalTo: firstIconBelow.centerYAnchor),
            secondIconBelow.widthAnchor.constraint(equalToConstant: 14),
            secondIconBelow.heightAnchor.constraint(equalToConstant: 14)
        ])
        
        NSLayoutConstraint.activate([
            secondValueBelow.leadingAnchor.constraint(equalTo: secondIconBelow.trailingAnchor, constant: 5),
            secondValueBelow.centerYAnchor.constraint(equalTo: firstIconBelow.centerYAnchor),
            secondValueBelow.widthAnchor.constraint(equalToConstant: 21),
            secondValueBelow.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            thirdIconBelow.leadingAnchor.constraint(equalTo: secondValueBelow.trailingAnchor),
            thirdIconBelow.centerYAnchor.constraint(equalTo: firstIconBelow.centerYAnchor),
            thirdIconBelow.widthAnchor.constraint(equalToConstant: 12),
            thirdIconBelow.heightAnchor.constraint(equalToConstant: 14)
        ])
        
        NSLayoutConstraint.activate([
            thirdValueBelow.leadingAnchor.constraint(equalTo: thirdIconBelow.trailingAnchor, constant: 4),
            thirdValueBelow.centerYAnchor.constraint(equalTo: firstIconBelow.centerYAnchor),
            thirdValueBelow.widthAnchor.constraint(equalToConstant: 100),
            thirdValueBelow.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
