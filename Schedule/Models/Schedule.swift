//
//  Schedule.swift
//  Schedule
//
//  Created by evanecen on 09/12/2018.
//  Copyright © 2018 evanecen. All rights reserved.
//

import Foundation

fileprivate let format = "MMMM d, yyyy h:mm a"

struct Schedule: Decodable {
    let title: String
    let start: String
    let end: String
    
    var startDate: Date? {
        return start.date(with: format)
    }
    
    var endDate: Date? {
        return end.date(with: format)
    }
}
