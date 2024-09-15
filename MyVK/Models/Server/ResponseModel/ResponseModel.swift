//
//  ResponseModel.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 12.09.2024.
//

import Foundation

struct ArrayResponseModel<T: Decodable>: Decodable {
    let response: ArrayInnerResponseModel<T>
}

struct ArrayInnerResponseModel<T: Decodable>: Decodable {
    let count: Int?
    let items: [T]?
}
