//
//  DateFormatter.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 15.09.2024.
//

import Foundation

struct DateFormatter {
    static func formattedDate(from dateString: String) -> String {
        let dateComponents = dateString.split(separator: ".")
        
        switch dateComponents.count {
        case 1:
            // MARK: only day
            let year = dateComponents[0]
            return "\(year) год"
        case 2:
            // MARK: day and month
            let day = dateComponents[0]
            let month = dateComponents[1]
            return "\(day) \(monthName(from: month))"
        case 3:
            // MARK: full date
            let day = dateComponents[0]
            let month = dateComponents[1]
            let year = dateComponents[2]
            
            if let yearInt = Int(year), let age = calculateAge(from: yearInt) {
                return ageString(from: age)
            } else {
                return "\(day) \(monthName(from: month)) \(year) год"
            }
        default:
            return ""
        }
    }
    
    private static func monthName(from month: Substring) -> String {
        switch month {
        case "1": return "января"
        case "2": return "февраля"
        case "3": return "марта"
        case "4": return "апреля"
        case "5": return "мая"
        case "6": return "июня"
        case "7": return "июля"
        case "8": return "августа"
        case "9": return "сентября"
        case "10": return "октября"
        case "11": return "ноября"
        case "12": return "декабря"
        default: return ""
        }
    }
    
    private static func calculateAge(from year: Int) -> Int? {
        let currentYear = Calendar.current.component(.year, from: Date())
        return currentYear - year
    }
    
    private static func ageString(from age: Int) -> String {
        let lastDigit = age % 10
        if (age % 100 >= 11 && age % 100 <= 19) {
            return "\(age) лет"
        } else if (lastDigit == 1) {
            return "\(age) год"
        } else if (lastDigit >= 2 && lastDigit <= 4) {
            return "\(age) года"
        } else {
            return "\(age) лет"
        }
    }
}

extension DateFormatter {
    static func lastSeenDate(from date: Date) -> String {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .hour, .day], from: date, to: now)
        
        if let days = components.day, days > 0 {
            let formatter = Foundation.DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter.string(from: date)
        } else if let hours = components.hour, hours > 0 {
            let formatter = Foundation.DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes) минут назад"
        } else {
            return "Только что"
        }
    }
}
