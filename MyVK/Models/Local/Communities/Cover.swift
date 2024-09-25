//
//  Cover.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 25.09.2024.
//

import Foundation

struct Cover: Equatable {
    let enabled: Bool
    let images: [CoverImage]
}

struct CoverImage: Equatable {
    let url: URL?
    let width: Int?
}

extension Cover {
    init(from serverCover: ServerCover) {
        self.enabled = serverCover.enabled == 1
        self.images = serverCover.images?.compactMap { CoverImage(from: $0) } ?? []
    }
}

extension CoverImage {
    init(from serverCoverImage: ServerCoverImage) {
        self.url = URL(string: serverCoverImage.url.orEmpty)
        self.width = serverCoverImage.width
    }
}
