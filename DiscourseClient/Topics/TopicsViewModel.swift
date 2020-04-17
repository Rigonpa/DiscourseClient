//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
}

/// ViewModel que representa un listado de topics
/*
 Para no copiar y pegar tanto código, te propondría meter lo que se repite en una función,
 y llamarla desde donde sea necesario
 */
class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    let topicsDataManager: TopicsDataManager
    var topicViewModels: [TopicCellViewModel] = []

    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }

    func viewWasLoaded() {
        fetchTopicsAndUpdateUI()
    }

    fileprivate func fetchTopicsAndUpdateUI() {
        self.topicsDataManager.fetchAllTopics { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.viewDelegate?.errorFetchingTopics()
            case .success(let latestTopicsResponse):
                guard let latestTopicsResponse = latestTopicsResponse else { return }
                for each in 0...(latestTopicsResponse.topicList.topics.count - 1) {
                    self.topicViewModels.append(TopicCellViewModel(topic: latestTopicsResponse.topicList.topics[each]))
                }
                self.viewDelegate?.topicsFetched()
            }
        }
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return topicViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> TopicCellViewModel? {
        guard indexPath.row < topicViewModels.count else { return nil }
        return topicViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < topicViewModels.count else { return }  // Para evitar desbordamiento de array
        coordinatorDelegate?.didSelect(topic: topicViewModels[indexPath.row].topic)
    }

    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }

    func newTopicWasCreated() {
        topicViewModels.removeAll()
        fetchTopicsAndUpdateUI()
    }
    
    func updateTableAfterTopicDeleted() {
        topicViewModels.removeAll()
        fetchTopicsAndUpdateUI()
    }
}
