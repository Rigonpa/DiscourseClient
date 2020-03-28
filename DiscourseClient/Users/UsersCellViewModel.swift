//
//  UsersCellViewModel.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 25/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserViewCellDelegate {
    func userImageFetched()
}

class UsersCellViewModel {
    let user: User
    let usernameLabel: String?
    var avatarData: Data?
    var viewDelegate: UserViewCellDelegate?
    //var imageClosure: (() -> Void)?
    
    init(user: User) {
        self.user = user
        usernameLabel = user.username
        avatarPathCompleted()
    }
    

    func avatarPathCompleted() {
        let url = "https://mdiscourse.keepcoding.io/"
        let changed = user.avatarTemplate.replacingOccurrences(of: "{size}", with: "75")
        guard let urlCompleted = URL(string: "\(url)\(changed)") else { return }
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            guard let imageData = try? Data(contentsOf: urlCompleted) else { return }
            DispatchQueue.main.async {
                self.avatarData = imageData
                self.viewDelegate?.userImageFetched()
                //self.imageClosure?()
            }
        }
    }
}
