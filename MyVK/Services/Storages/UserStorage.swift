//
//  UserStorage.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 03.09.2024.
//

import Foundation

struct UserStorage {
    static var shared = UserStorage()
    
    private let defaults = UserDefaults()
    
    private init() {}
}


// MARK: -- Properties
extension UserStorage {
    var token: String? {
        get {
            defaults.string(forKey: Key.token.rawValue)
        }
        set {
            defaults.setValue(newValue, forKey: Key.token.rawValue)
        }
    }
    
    var userID: String? {
        get {
            defaults.string(forKey: Key.userID.rawValue)
        }
        set {
            defaults.setValue(newValue, forKey: Key.userID.rawValue)
        }
    }
}


// MARK: -- Keys
extension UserStorage {
    enum Key: String {
        case token
        case userID
    }
}
