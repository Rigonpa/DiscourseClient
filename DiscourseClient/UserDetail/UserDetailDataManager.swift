//
//  UserDetailDataManager.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserDetailDataManager {
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse, Error>) -> Void)
}
