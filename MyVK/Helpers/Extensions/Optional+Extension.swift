//
//  Optional+Extension.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 12.09.2024.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? ""
    }
}

extension Optional where Wrapped == Int {
    var orZero: Int {
        self ?? 0
    }
}
