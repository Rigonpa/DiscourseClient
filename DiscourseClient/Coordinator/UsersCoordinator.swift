//
//  UsersCoordinator.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 25/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersCoordinator: Coordinator {
        
    let presenter: UINavigationController
    let usersDataManager: UsersDataManager
    let userDetailDataManager: UserDetailDataManager
    var usersViewModel: UsersViewModel?
    
    init(presenter: UINavigationController, usersDataManager: UsersDataManager, userDetailDataManager: UserDetailDataManager) {
        self.presenter = presenter
        self.usersDataManager = usersDataManager
        self.userDetailDataManager = userDetailDataManager
    }
    
    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.title = NSLocalizedString("Users", comment: "")
        usersViewModel.coordinatorDelegate = self
        usersViewModel.viewDelegate = usersViewController
        presenter.pushViewController(usersViewController, animated: false)
    }
    
    override func finish() {}
}

extension UsersCoordinator: UsersCoordinatorDelegate {
    func didSelect(username: String) {
        let userDetailViewModel = UserDetailViewModel(username: username, userDetailDataManager: userDetailDataManager)
        let userDetailViewController = UserDetailViewController(viewModel: userDetailViewModel)
        
        userDetailViewController.title = NSLocalizedString("User Detail", comment: "")
        userDetailViewModel.coordinatorDelegate = self
        userDetailViewModel.viewDelegate = userDetailViewController
        
        presenter.pushViewController(userDetailViewController, animated: true)
    }
}

extension UsersCoordinator: UserDetailCoordinatorDelegate {
    func nameSuccessfullyUpdated() {
        presenter.popViewController(animated: true)
        usersViewModel?.nameIsUpdated()
    }
    
    func backButtonTapped() {
        presenter.popViewController(animated: true)
    }

}
