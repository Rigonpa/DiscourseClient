//
//  TopicsCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator que representa la pila de navegación del topics list.
/// Tiene como hijo el AddTopicCoordinator
class TopicsCoordinator: Coordinator {
    let presenter: UINavigationController
    let topicsDataManager: TopicsDataManager
    let topicDetailDataManager: TopicDetailDataManager
    let addTopicDataManager: AddTopicDataManager
    var topicsViewModel: TopicsViewModel?

    init(presenter: UINavigationController, topicsDataManager: TopicsDataManager,
         topicDetailDataManager: TopicDetailDataManager,
         addTopicDataManager: AddTopicDataManager) {

        self.presenter = presenter
        self.topicsDataManager = topicsDataManager
        self.topicDetailDataManager = topicDetailDataManager
        self.addTopicDataManager = addTopicDataManager
    }

    override func start() {
        let topicsViewModel = TopicsViewModel(topicsDataManager: topicsDataManager)
        let topicsViewController = TopicsViewController(viewModel: topicsViewModel)
        topicsViewController.title = NSLocalizedString("Topics", comment: "")
        topicsViewModel.viewDelegate = topicsViewController
        topicsViewModel.coordinatorDelegate = self
        self.topicsViewModel = topicsViewModel
        presenter.pushViewController(topicsViewController, animated: false)
    }

    override func finish() {}
}

extension TopicsCoordinator: TopicsCoordinatorDelegate {
    func didSelect(topic: Topic) {
        
        let topicDetailViewModel = TopicDetailViewModel(topicID: topic.id, topicDetailDataManager: topicDetailDataManager)
        let topicDetailViewController = TopicDetailViewController(viewModel: topicDetailViewModel)
        topicDetailViewModel.viewDelegate = topicDetailViewController
        topicDetailViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(topicDetailViewController, animated: true)

    }

    func topicsPlusButtonTapped() {
        let addTopicCoordinator = AddTopicCoordinator(presenter: presenter, addTopicDataManager: addTopicDataManager)
        addChildCoordinator(addTopicCoordinator)
        addTopicCoordinator.start()

        addTopicCoordinator.onCancelTapped = { [weak self] in
            guard let self = self else { return }

            addTopicCoordinator.finish()
            self.removeChildCoordinator(addTopicCoordinator)
        }

        addTopicCoordinator.onTopicCreated = { [weak self] in
            guard let self = self else { return }
            
            // Si ponemos finish y removeChild antes de newTopicWasCreated la tabla no se recarga a tiempo:
            self.topicsViewModel?.newTopicWasCreated()
            addTopicCoordinator.finish()
            self.removeChildCoordinator(addTopicCoordinator)
        }
    }
}

extension TopicsCoordinator: TopicDetailCoordinatorDelegate {
    func topicDetailDeleteButtonTapped() {
        topicsViewModel?.updateTableAfterTopicDeleted()
        presenter.popViewController(animated: true)
    }
    
    func topicDetailBackButtonTapped() {
        presenter.popViewController(animated: true)
    }
}
