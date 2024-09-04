//
//  Consts.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 03.09.2024.
//

import Foundation

enum Consts {
    enum Auth {
        static let vkURL = "https://oauth.vk.com/authorize"
        static let clientIDKey = "client_id"
        static let clientIDValue = "52228274"
        static let displayKey = "display"
        static let displayValue = "mobile"
        static let scopeKey = "scope"
        static let scopeValue = "offline,friends,groups,wall,photos"
        static let responseTypeKey = "response_type"
        static let responseTypeValue = "token"
        static let redirectUriKey = "redirect_uri"
        static let redirectUriValue = "https://oauth.vk.com/blank.html"
    }
}
