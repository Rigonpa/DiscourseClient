//
//  UsersDataManager.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 25/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UsersDataManager {
    func fetchUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())
}
