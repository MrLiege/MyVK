//
//  Date+Extension.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 15.09.2024.
//

import Foundation

extension Date {
    static func getDateFromUnix(time: Int?) -> Date? {
        guard let time else { return nil }
        return Date(timeIntervalSince1970: Double(time))
    }
}
