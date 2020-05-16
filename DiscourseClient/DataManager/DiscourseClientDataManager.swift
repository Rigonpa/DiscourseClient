//
//  DiscourseClientDataManager.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation


/// DataManager de la app. Usa un localDataManager y un remoteDataManager que colaboran entre ellos
/// En las extensiones de abajo, encontramos la implementación de aquellos métodos necesarios en cada módulo de la app
/// Este DataManager sólo utiliza llamadas remotas, pero podría extenderse para serialziar las respuestas, y poder implementar un offline first en el futuro
class DiscourseClientDataManager {
    let localDataManager: DiscourseClientLocalDataManager
    let remoteDataManager: DiscourseClientRemoteDataManager

    init(localDataManager: DiscourseClientLocalDataManager, remoteDataManager: DiscourseClientRemoteDataManager) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
}

extension DiscourseClientDataManager: TopicsDataManager {
    // func fetchAllTasks() en TaskApp de persistencia {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllTopics(completion: completion)
        // database.fetchData() en TaskApp de persistencia {  } }
    }
}

extension DiscourseClientDataManager: TopicDetailDataManager {
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ()) {
        remoteDataManager.deleteTopic(id: id, completion: completion)
    }
    
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        remoteDataManager.fetchTopic(id: id, completion: completion)
    }
}

extension DiscourseClientDataManager: AddTopicDataManager {
    func addTopic(title: String, raw: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        remoteDataManager.addTopic(title: title, raw: raw, completion: completion)
    }
}

extension DiscourseClientDataManager: CategoriesDataManager {
    func fetchCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ()) {
        remoteDataManager.fetchCategories(completion: completion)
    }
}

extension DiscourseClientDataManager: UsersDataManager {
    
    func fetchUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        remoteDataManager.fetchUsers(completion: completion)
    }
}

extension DiscourseClientDataManager: UserDetailDataManager {
    
    func updateUserName(username: String, newName: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> Void) {
        remoteDataManager.updateUserName(username: username, newName: newName, completion: completion)
    }
    
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> Void) {
        remoteDataManager.fetchUser(username: username, completion: completion)
    }
}
