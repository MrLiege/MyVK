//
//  UserPhoto.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 17.09.2024.
//

import Foundation

struct UserPhoto: Identifiable {
    let id: Int
    let date: Date?
    let sizes: [UserPhotoSize]
}

extension UserPhoto {
    init?(from dto: ServerPhotoModel) {
        guard let dtoSizes = dto.sizes else { return nil }
        
        let fillSizes = dtoSizes.compactMap({ UserPhotoSize(from: $0) })
        
        if fillSizes.isEmpty { return nil }
        
        id = dto.id
        sizes = fillSizes
        
        if let dtoDate = dto.date {
            date = Date(timeIntervalSince1970: Double(dtoDate))
        } else {
            date = nil
        }
    }
}

struct UserPhotoSize: Identifiable, Equatable {
    let id = UUID()
    let height: Double
    let width: Double
    let type: String?
    let url: URL?
    
    var isHorizontal: Bool {
        width > height
    }
    
    var size: CGSize {
        .init(width: width, height: height)
    }
}

extension UserPhotoSize {
    init?(from dto: ServerPhotoSize) {
        guard let dtoWidth = dto.width,
              let dtoHeight = dto.height,
              let dtoURL = dto.url
        else { return nil }
        
        height = dtoHeight
        width = dtoWidth
        type = dto.type
        url = URL(string: dtoURL)
    }
}
