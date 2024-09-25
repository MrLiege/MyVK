//
//  ServerMainAddress.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 25.09.2024.
//

import Foundation

struct ServerMainAddress: Decodable {
    let id: Int?
    let additionalAddress: String?
    let address: String?
    let city: ServerCity?
    let country: ServerCountry?
    let title: String?
    let workInfoStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case additionalAddress = "additional_address"
        case address
        case city
        case country
        case title
        case workInfoStatus = "work_info_status"
    }
}

struct ServerCity: Decodable {
    let id: Int?
    let title: String?
}

struct ServerCountry: Decodable {
    let id: Int?
    let title: String?
}
