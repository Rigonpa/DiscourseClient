//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol TopicDataCellViewDelegate {
    func onShowingAvatar()
}

/// ViewModel que representa un topic en la lista
class TopicDataCellViewModel: TopicCellViewModel {
    
    var dateAfterFormatter: String?
    var cellViewDelegate: TopicDataCellViewDelegate?
    var avatarImage: UIImage?
    
    let topic: Topic
    let user: User
    init(topic: Topic, user: User) {
        self.topic = topic
        self.user = user
        super.init()
        
        self.changingDateFormat(before: topic.lastPostedAt)
        var imageStringURL = "https://mdiscourse.keepcoding.io"
        imageStringURL.append(self.user.avatarTemplate.replacingOccurrences(of: "{size}", with: "75"))
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            guard let avatarUrl = URL(string: imageStringURL) else { return }
            
            do {
                let imageData = try Data(contentsOf: avatarUrl)
                self.avatarImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.cellViewDelegate?.onShowingAvatar()
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func changingDateFormat(before: String) {
        
        let beforeFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = beforeFormat
        
        // Generating date with before formatted structured:
        guard let beforeDate = dateFormatter.date(from: before) else { return }
        
        let afterFormat = "MMM yy"
        dateFormatter.dateFormat = afterFormat
        dateAfterFormatter = dateFormatter.string(from: beforeDate)
    }
}
