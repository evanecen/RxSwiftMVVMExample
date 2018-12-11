//
//  StringExtension.swift
//  Schedule
//
//  Created by evanecen on 09/12/2018.
//  Copyright © 2018 evanecen. All rights reserved.
//

import Foundation

extension String {
    func date(with format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
