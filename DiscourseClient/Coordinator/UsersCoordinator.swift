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
    
    init(presenter: UINavigationController, usersDataManager: UsersDataManager) {
        self.presenter = presenter
        self.usersDataManager = usersDataManager
    }
    
    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.title = NSLocalizedString("Users", comment: "")
        //usersViewModel.coordinatorDelegate = self
        usersViewModel.viewDelegate = usersViewController
        presenter.pushViewController(usersViewController, animated: false)
    }
    
    override func finish() {}
}

//extension UsersCoordinator: UsersCoordinatorDelegate {
//    func didSelect() {
//
//    }
//}
