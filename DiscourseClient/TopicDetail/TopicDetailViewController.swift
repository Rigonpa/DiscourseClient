//
//  TopicDetailViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa el detalle de un Topic
class TopicDetailViewController: UIViewController {

    lazy var labelTopicID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelTopicTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var topicIDStackView: UIStackView = {
        let labelTopicIDTitle = UILabel()
        labelTopicIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicIDTitle.text = NSLocalizedString("Topic ID: ", comment: "")
        labelTopicIDTitle.textColor = .black

        let topicIDStackView = UIStackView(arrangedSubviews: [labelTopicIDTitle, labelTopicID])
        topicIDStackView.translatesAutoresizingMaskIntoConstraints = false
        topicIDStackView.isHidden = true
        topicIDStackView.axis = .horizontal

        return topicIDStackView
    }()

    lazy var topicNameStackView: UIStackView = {
        let labelTopicTitleTitle = UILabel()
        labelTopicTitleTitle.text = NSLocalizedString("Topic name: ", comment: "")
        labelTopicTitleTitle.translatesAutoresizingMaskIntoConstraints = false

        let topicNameStackView = UIStackView(arrangedSubviews: [labelTopicTitleTitle, labelTopicTitle])
        topicNameStackView.translatesAutoresizingMaskIntoConstraints = false
        topicNameStackView.isHidden = true
        topicNameStackView.axis = .horizontal

        return topicNameStackView
    }()
    
    lazy var deleteButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(NSLocalizedString("Delete", comment: ""), for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.orange
        btn.layer.cornerRadius = 5.0
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = true
        btn.addTarget(self, action: #selector(onDeleteButtonTapped), for: .touchUpInside)
        return btn
    }()

    let viewModel: TopicDetailViewModel

    init(viewModel: TopicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(topicIDStackView)
        NSLayoutConstraint.activate([
            topicIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(topicNameStackView)
        NSLayoutConstraint.activate([
            topicNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicNameStackView.topAnchor.constraint(equalTo: topicIDStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            deleteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 45),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])

        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    @objc func onDeleteButtonTapped() {
        viewModel.deleteButtonTapped()
    }

    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }

    fileprivate func showErrorFetchingTopicDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topic detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func showErrorDeletingTopicAlert() {
        let alertMessage: String = NSLocalizedString("Error deleting topic\nPlease try again", comment: "")
        showAlert(alertMessage)
    }

    fileprivate func updateUI() {
        labelTopicID.text = viewModel.labelTopicIDText
        labelTopicTitle.text = viewModel.labelTopicNameText
        topicIDStackView.isHidden = false
        topicNameStackView.isHidden = false
        /*
         No está mal hacerlo asím pero para ser más fiel a MVVM, te propondría añadir
         una propiedad deleteButtonIsHidden en el viewModel, de forma que la consultarías
         igual que lo haces por ejemplo con labelTopicID.text = viewModel.labelTopicIDText.
         De esta forma movemos esta lógica fuera del ViewController al ViewModel, donde
         podemos añadir unit tests en el futuro 💪
         */
        if let topicDeletable = viewModel.topicIsDeletable, let topicClosed = viewModel.topicIsClosed {
            if topicDeletable && !topicClosed {
                deleteButton.isHidden = false
            }
        }
        
    }
}

extension TopicDetailViewController: TopicDetailViewDelegate {
    
    func topicDetailFetched() {
        updateUI()
    }

    func errorFetchingTopicDetail() {
        showErrorFetchingTopicDetailAlert()
    }
    
    func errorDeletingTopic() {
        showErrorDeletingTopicAlert()
    }
}
