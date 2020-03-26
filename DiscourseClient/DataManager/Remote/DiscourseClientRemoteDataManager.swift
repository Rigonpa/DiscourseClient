//
//  DiscourseClientRemoteDataManager.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Protocolo que contiene todas las llamadas remotas de la app
protocol DiscourseClientRemoteDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse, Error>) -> ())
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse, Error>) -> ())
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse, Error>) -> ())
    //func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse, Error>) -> ())
    func addTopic(title: String, raw: String, completion: @escaping (Result<AddNewTopicResponse, Error>) -> ())
    func fetchCategories(completion: @escaping (Result<CategoriesResponse, Error>) -> ())
    func fetchUsers(completion: @escaping (Result<UsersResponse, Error>) -> ())
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse, Error>) -> ())
}