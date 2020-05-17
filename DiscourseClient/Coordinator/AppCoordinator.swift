//
//  AppCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator principal de la app. Encapsula todas las interacciones con la Window.
/// Tiene tres hijos, el topic list, el categories list y el users list (uno por cada tab item)
class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()

    lazy var remoteDataManager: DiscourseClientRemoteDataManager = {
        let remoteDataManager = DiscourseClientRemoteDataManagerImpl(session: sessionAPI)
        return remoteDataManager
    }()

    // This variable localDataManager is a LocalDataManagerImpl object. That is why
    // in DCDataManager we can use only LocalDataManager and not LocalDataManagerImpl.
    // DataManger does not know to DataManagerImpl but AppCoordinator does.
    lazy var localDataManager: DiscourseClientLocalDataManager = {
        let localDataManager = DiscourseClientLocalDataManagerImpl()
        return localDataManager
    }()

    lazy var dataManager: DiscourseClientDataManager = {
        let dataManager = DiscourseClientDataManager(localDataManager: self.localDataManager, remoteDataManager: self.remoteDataManager)
        return dataManager
    }()

    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        let tabBarController = UITabBarController()

        let topicsNavigationController = UINavigationController()
        let topicsCoordinator = TopicsCoordinator(presenter: topicsNavigationController,
                                                  topicsDataManager: dataManager,
                                                  topicDetailDataManager: dataManager,
                                                  addTopicDataManager: dataManager)
        addChildCoordinator(topicsCoordinator)
        topicsCoordinator.start()

        let categoriesNavigationController = UINavigationController()
        let categoriesCoordinator = CategoriesCoordinator(presenter: categoriesNavigationController,
                                                          categoriesDataManager: dataManager)
        addChildCoordinator(categoriesCoordinator)
        categoriesCoordinator.start()
        
        let usersNavigationController = UINavigationController()
        let usersCoordinator = UsersCoordinator(presenter: usersNavigationController,
                                                usersDataManager: dataManager,
                                                userDetailDataManager: dataManager)
        
        addChildCoordinator(usersCoordinator)
        usersCoordinator.start()

        tabBarController.tabBar.tintColor = .black

        tabBarController.viewControllers = [topicsNavigationController, categoriesNavigationController, usersNavigationController]
        
        let topicsImageSelected = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        let topicsImageUnselected = UIImage(named: "homeUnselected")?.withRenderingMode(.alwaysOriginal)
        let topicsTabBarItem: UITabBarItem = UITabBarItem(title: "Topics", image: topicsImageUnselected, selectedImage: topicsImageSelected)
        topicsNavigationController.tabBarItem = topicsTabBarItem
        
        let categoriesImageSelected = UIImage(named: "categories")?.withRenderingMode(.alwaysOriginal)
        let categoriesImageUnselected = UIImage(named: "categoriesUnselected")?.withRenderingMode(.alwaysOriginal)
        let categoriesTabBarItem: UITabBarItem = UITabBarItem(title: "Categories", image: categoriesImageUnselected, selectedImage: categoriesImageSelected)
        categoriesNavigationController.tabBarItem = categoriesTabBarItem
//        categoriesNavigationController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
//        categoriesNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let usersImageSelected = UIImage(named: "users")?.withRenderingMode(.alwaysOriginal)
        let usersImageUnselected = UIImage(named: "usersUnselected")?.withRenderingMode(.alwaysOriginal)
        let usersTabBarItem: UITabBarItem = UITabBarItem(title: "Users", image: usersImageUnselected, selectedImage: usersImageSelected)
        usersNavigationController.tabBarItem = usersTabBarItem
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    override func finish() {}
}
