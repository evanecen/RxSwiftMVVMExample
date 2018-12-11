//
//  ScheduleViewModel.swift
//  Schedule
//
//  Created by evanecen on 09/12/2018.
//  Copyright © 2018 evanecen. All rights reserved.
//

import Foundation

fileprivate let dayFormat = "MMMM d"
fileprivate let timeFormat = "h:mma"

protocol ScheduleViewModelProtocol {
    var title: String { get }
    var startDate: Date? { get }
    var endDate: Date? { get }
    
    var timeString: String { get }
    var dayString: String { get }
    var isCollision: Bool { get }
}

struct ScheduleViewModel: ScheduleViewModelProtocol {
    var title: String
    var startDate: Date?
    var endDate: Date?
    
    var timeString: String {
        guard let startDate = startDate, let endDate = endDate else { return "" }
        return startDate.string(with: timeFormat) + " - " + endDate.string(with: timeFormat)
    }
    
    var dayString: String {
        guard let startDate = startDate else { return "" }
        return startDate.string(with: dayFormat)
    }
    
    var isCollision: Bool = false
    
    init(with model: Schedule) {
        title = model.title
        startDate = model.startDate
        endDate = model.endDate
    }
}
