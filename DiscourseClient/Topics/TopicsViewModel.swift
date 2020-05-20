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
class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    let topicsDataManager: TopicsDataManager
    var topicViewModels: [TopicCellViewModel] = []

    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }

    func viewWasLoaded() {
        
        self.topicsDataManager.fetchAllTopics { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.viewDelegate?.errorFetchingTopics()
            case .success(let latestTopicsResponse):
                guard let latestTopicsResponse = latestTopicsResponse else { return }
                for each in 0...(latestTopicsResponse.topicList.topics.count - 1) {
                    let myUser = latestTopicsResponse.users.filter { (user) -> Bool in
                        user.username == latestTopicsResponse.topicList.topics[each].lastPoster
                    }
                    self.topicViewModels.append(TopicDataCellViewModel(
                        topic: latestTopicsResponse.topicList.topics[each],
                        user: myUser[0]))
                }
                self.topicViewModels.insert(WelcomeCellViewModel(), at: 0)
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
        guard indexPath.row < topicViewModels.count else { return } // Para evitar desbordamiento de array
        guard let topicCellViewModel = topicViewModels[indexPath.row] as? TopicDataCellViewModel else { return } // Downcasting because of inheritance.
        coordinatorDelegate?.didSelect(topic: topicCellViewModel.topic)
    }

    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }

    func newTopicWasCreated() {
        
        topicViewModels.removeAll()
        self.topicsDataManager.fetchAllTopics { [weak self] (result) in
        guard let self = self else { return }
            switch result {
            case .failure(_):
//                print(error.localizedDescription)
                self.viewDelegate?.errorFetchingTopics()
            case .success(let latestTopicsResponse):
                guard let latestTopicsResponse = latestTopicsResponse else { return }
                for each in 0...latestTopicsResponse.topicList.topics.count - 1 {
                    let myUser = latestTopicsResponse.users.filter { (user) -> Bool in
                        user.username == latestTopicsResponse.topicList.topics[each].lastPoster
                    }
                    self.topicViewModels.append(TopicDataCellViewModel(topic: latestTopicsResponse.topicList.topics[each], user: myUser[0]))
                }
                self.viewDelegate?.topicsFetched()
            }
        }
    }
    
    func updateTableAfterTopicDeleted() {
        
        topicViewModels.removeAll()
        self.topicsDataManager.fetchAllTopics { [weak self] (result) in
        guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.viewDelegate?.errorFetchingTopics()
            case .success(let latestTopicsResponse):
                guard let latestTopicsResponse = latestTopicsResponse else { return }
                for each in 0...latestTopicsResponse.topicList.topics.count - 1 {
                    let myUser = latestTopicsResponse.users.filter { (user) -> Bool in
                        user.username == latestTopicsResponse.topicList.topics[each].lastPoster
                    }
                    self.topicViewModels.append(TopicDataCellViewModel(topic: latestTopicsResponse.topicList.topics[each], user: myUser[0]))
                }
                self.viewDelegate?.topicsFetched()
            }
        }
    }
}

//extension TopicsViewModel: TopicDataCellViewModelDelegate {
//    func onSelectingProfileUserImage(lastPoster: String, completion: @escaping (String) -> ()) {
//        var users: [User] = []
//        self.topicsDataManager.fetchAllTopics {[weak self] (result) in
//            guard let self = self else { return }
//            switch result {
//            case .success(let response):
//                guard let response = response else { return }
//                for each in 0...response.users.count - 1 {
//                    users.append(response.users[each])
//                }
//                completion(self.onPickingUserAvatar(lastPoster: lastPoster, users: users))
//            case .failure(let error):
//                print(error.localizedDescription)
//                self.viewDelegate?.errorFetchingTopics()
//                completion("")
//            }
//        }
////        completion(self.onPickingUserAvatar!(lastPoster)) - Closure that won't use but want to keep it here.
//    }
//
//    private func onPickingUserAvatar(lastPoster: String, users: [User]) -> String {
//        let user = users.filter { (user) -> Bool in
//            user.username == lastPoster
//        }
//        return user[0].avatarTemplate
//    }
//}
