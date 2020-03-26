//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 25/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UsersCoordinatorDelegate {
    func didSelect()
}

protocol UsersViewDelegate {
    func usersFetched()
    func errorFetchingUsers()
}

class UsersViewModel {
    
    var users: [UsersCellViewModel] = []
    
    let usersDataManager: UsersDataManager
    var coordinatorDelegate: UsersCoordinatorDelegate?
    var viewDelegate: UsersViewDelegate?
    
    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }
    
    func viewDidLoad() {
        usersDataManager.fetchUsers { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.viewDelegate?.errorFetchingUsers()
            case .success(let usersResponse):
                for each in 0...usersResponse.directoryItems.count - 1 {
                    self.users.append(UsersCellViewModel(user: usersResponse.directoryItems[each].user))
                }
                self.viewDelegate?.usersFetched()
            }
        }
    }
    
    func sections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return users.count
    }
    
    func setCellForRow(indexPath: Int) -> UsersCellViewModel? {
        return users[indexPath]
    }
    
    
}
