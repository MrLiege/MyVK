//
//  Int+Extension.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 25.09.2024.
//

import Foundation

extension Int {
    func formatted() -> String {
        switch self {
        case 0..<1000:
            return "\(self)"
        case 1000..<1000000:
            let formattedNumber = Double(self) / 1000
            return String(format: "%.2fк", formattedNumber)
        case 1000000..<1000000000:
            let formattedNumber = Double(self) / 1000000
            return String(format: "%.2fм", formattedNumber)
        default:
            return "\(self)"
        }
    }
    
    func formattedSubscribers() -> String {
        let formattedNumber = self.formatted()
        let suffix = self.getSubscribersSuffix()
        return "\(formattedNumber) \(suffix)"
    }
    
    private func getSubscribersSuffix() -> String {
        let lastDigit = self % 10
        let lastTwoDigits = self % 100
        
        if lastTwoDigits >= 11 && lastTwoDigits <= 19 {
            return "подписчиков"
        }
        
        switch lastDigit {
        case 1:
            return "подписчик"
        case 2, 3, 4:
            return "подписчика"
        default:
            return "подписчиков"
        }
    }
}
