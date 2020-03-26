//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserDetailCoordinatorDelegate: class {
    func updateButtonTapped()
    func backButtonTapped()
}

protocol UserDetailViewDelegate: class {
    func singleUserFetched()
    func errorFetchingSingleUser()
}

class UserDetailViewModel {
    let username: String
    let userDetailDataManager: UserDetailDataManager
    weak var coordinatorDelegate: UserDetailCoordinatorDelegate?
    weak var viewDelegate: UserDetailViewDelegate?
    
    var idValue: Int?
    var nameNoEditableValue: String?
    var usernameValue: String?
    var nameIsEditableBool: Bool?
    
    init(username: String, userDetailDataManager: UserDetailDataManager) {
        self.username = username
        self.userDetailDataManager = userDetailDataManager
    }
    
    func viewDidLoad() {
        userDetailDataManager.fetchUser(username: username) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.viewDelegate?.errorFetchingSingleUser()
            case .success(let singleUserResponse):
                self.idValue = singleUserResponse.user.id
                self.nameNoEditableValue = singleUserResponse.user.name ?? ""
                self.usernameValue = singleUserResponse.user.username
                self.nameIsEditableBool = singleUserResponse.user.canEditName
                self.viewDelegate?.singleUserFetched()
            }
        }
    }
    
    func backButtonIsTapped() {
        coordinatorDelegate?.backButtonTapped()
    }
}


