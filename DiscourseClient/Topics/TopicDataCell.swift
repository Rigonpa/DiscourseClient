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
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.alpha = 0
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
        iv.contentMode = .scaleAspectFill
        iv.layer.opacity = 0.7
        return iv
    }()
    
    lazy var firstValueBelow: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.layer.opacity = 0.5
        return label
    }()
    
    lazy var secondIconBelow: UIImageView = {
        guard let image = UIImage(named: "icoViewsSmall") else { fatalError() }
        let iv = UIImageView()
        iv.image = image
        iv.contentMode = .scaleAspectFill
        iv.layer.opacity = 0.7
        return iv
    }()
    
    lazy var secondValueBelow: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.layer.opacity = 0.5
        return label
    }()
    
    lazy var thirdIconBelow: UIImageView = {
        guard let image = UIImage(named: "icoSmallCalendar") else { fatalError() }
        let iv = UIImageView()
        iv.image = image
        iv.contentMode = .scaleAspectFill
        iv.layer.opacity = 0.7
        return iv
    }()
    
    lazy var thirdValueBelow: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.layer.opacity = 0.5
        return label
    }()
    
    lazy var postsStackView: UIStackView = {
        
        let sv = UIStackView(arrangedSubviews: [firstIconBelow, firstValueBelow])
        sv.axis = .horizontal
        sv.spacing = 7
        return sv
    }()
    
    lazy var viewsStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [secondIconBelow, secondValueBelow])
        sv.axis = .horizontal
        sv.spacing = 5
        return sv
    }()
    
    lazy var dateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [thirdIconBelow, thirdValueBelow])
        sv.axis = .horizontal
        sv.spacing = 7
        return sv
    }()
    
    lazy var metricsStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [postsStackView, viewsStackView, dateStackView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 10
        sv.axis = .horizontal
        return sv
    }()

    static let cellIdentifier: String = String(describing: TopicDataCell.self)
    var viewModel: TopicDataCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.cellViewDelegate = self
            setupUI()
            
            if let avatarImage = viewModel.avatarImage{
                topicImageView.alpha = 1
                topicImageView.image = avatarImage
            }
            
            topicTitleLabel.text = viewModel.topic.title
            firstValueBelow.text = String(viewModel.topic.postsCount)
            secondValueBelow.text = String(viewModel.topic.views)
            thirdValueBelow.text = viewModel.dateAfterFormatter
            
        }
    }
    
    private func setupUI() {
        contentView.addSubview(topicImageView)
        contentView.addSubview(topicTitleLabel)
        contentView.addSubview(metricsStackView)
        
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
            metricsStackView.leadingAnchor.constraint(equalTo: topicImageView.trailingAnchor, constant: 11),
            metricsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}

extension TopicDataCell: TopicDataCellViewDelegate {
    func onShowingAvatar() {
        guard let viewModel = self.viewModel else { return }
        
        guard let avatarImage = viewModel.avatarImage else { return }
        topicImageView.image = avatarImage
        
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            guard let self = self else { return }
            self.topicImageView.alpha = 1
        }, completion: nil)
        self.setNeedsLayout()
    }
}
