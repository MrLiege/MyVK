//
//  ServerPhotoModel.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 17.09.2024.
//

import Foundation

struct ServerPhotoModel: Decodable {
    let id: Int
    let date: Int?
    let sizes: [ServerPhotoSize]?
}

struct ServerPhotoSize: Decodable {
    let height: Double?
    let width: Double?
    let type: String?
    let url: String?
}
