//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// ViewModel que representa un topic en la lista
class TopicDataCellViewModel: TopicCellViewModel {
    
    let topic: Topic
    var dateAfterFormatter: String?
    init(topic: Topic) {
        self.topic = topic
        super.init()
        
        self.changingDateFormat(before: topic.createdAt)
    }
    
    private func changingDateFormat(before: String) {
        
//        let beforeFormat = "YYYY-MM-DD'T'HH:mm:ss.SSSZ"
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
