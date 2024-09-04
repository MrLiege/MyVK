//
//  AuthURLBuilder.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 03.09.2024.
//

import Foundation

struct AuthURLBuilder {
    static let current = AuthURLBuilder()
    
    private init() {}
    
    var url: URL? {
        guard var components = URLComponents(string: Consts.Auth.vkURL) else { return nil }
        
        let items = [
            URLQueryItem(name: Consts.Auth.clientIDKey, value: Consts.Auth.clientIDValue),
            URLQueryItem(name: Consts.Auth.displayKey, value: Consts.Auth.displayValue),
            URLQueryItem(name: Consts.Auth.redirectUriKey, value: Consts.Auth.redirectUriValue),
            URLQueryItem(name: Consts.Auth.responseTypeKey, value: Consts.Auth.responseTypeValue),
            URLQueryItem(name: Consts.Auth.scopeKey, value: Consts.Auth.scopeValue)
        ]
        
        components.queryItems = items
        
        return components.url
    }
}
