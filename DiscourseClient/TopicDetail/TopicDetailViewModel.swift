//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol TopicDetailCoordinatorDelegate: class {
    func topicDetailDeleteButtonTapped()
    func topicDetailBackButtonTapped()
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol TopicDetailViewDelegate: class {
    func topicDetailFetched()
    func errorFetchingTopicDetail()
    func errorDeletingTopic()
}

class TopicDetailViewModel {
    var labelTopicIDText: String?
    var labelTopicNameText: String?
    var topicIsDeletable: Bool?
    var topicIsClosed: Bool?

    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    let topicDetailDataManager: TopicDetailDataManager
    let topicID: Int

    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }

    func viewDidLoad() {
        topicDetailDataManager.fetchTopic(id: topicID) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.viewDelegate?.errorFetchingTopicDetail()
            case .success(let singleTopicResponse):
                guard let singleTopicResponse = singleTopicResponse else { return }
                self.labelTopicIDText = "\(singleTopicResponse.id)"
                self.labelTopicNameText = singleTopicResponse.title
                self.topicIsDeletable = singleTopicResponse.details.canDelete
                self.topicIsClosed = singleTopicResponse.closed
                self.viewDelegate?.topicDetailFetched()
            }
        }
    }
    
    func deleteButtonTapped() {
        
        topicDetailDataManager.deleteTopic(id: topicID) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.viewDelegate?.errorDeletingTopic()
            case .success(_):
                self.coordinatorDelegate?.topicDetailDeleteButtonTapped()
            }
        }
        coordinatorDelegate?.topicDetailDeleteButtonTapped()
        
        /* Solución propia para respuesta nil de delete topic:
        
        topicDetailDataManager.deleteTopic(id: topicID) { [weak self] (result) in
            guard let self = self else { return }

            // result viene como error porque al hacer delete no da respuesta y en
            // sessionAPI, empty está capturado como error.

            switch result {
            case .failure(let error):
                // Plan b ya que no puedo poner if error == "emptyData":
                if error.localizedDescription.isEqual("The operation couldn’t be completed. (DiscourseClient.SessionAPIError error 0.)") {
                    self.coordinatorDelegate?.topicDetailDeleteButtonTapped()
                } else {
                    print(error.localizedDescription)
                    self.viewDelegate?.errorDeletingTopic()
                }
            case .success(let deleteTopicResponse):
                self.coordinatorDelegate?.topicDetailDeleteButtonTapped()
            }
        }
        
        */
    }

    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
    }
}
