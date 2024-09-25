//
//  ServerAddresses.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 25.09.2024.
//

import Foundation

struct ServerAddresses: Decodable {
    let isEnabled: Bool?
    let mainAddressId: Int?
    let mainAddress: ServerMainAddress?
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case isEnabled = "is_enabled"
        case mainAddressId = "main_address_id"
        case mainAddress = "main_address"
        case count
    }
}
