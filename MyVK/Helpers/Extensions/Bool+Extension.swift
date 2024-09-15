//
//  Bool+Extension.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 15.09.2024.
//

import Foundation

extension Bool {
    static func getBoolFrom(value: Int?) -> Bool? {
        guard let value else { return nil }
        return value == 1
    }
}
