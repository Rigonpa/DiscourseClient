//
//  UsersCellViewModel.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 25/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol UserViewItemDelegate {
    func userImageFetched()
}

class UsersItemViewModel {
    let user: User
    var avatarImage: UIImage?
    var viewDelegate: UserViewItemDelegate?
    
    init(user: User) {
        self.user = user
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
                self.avatarImage = UIImage(data: imageData)
                self.viewDelegate?.userImageFetched()
            }
        }
    }
}
