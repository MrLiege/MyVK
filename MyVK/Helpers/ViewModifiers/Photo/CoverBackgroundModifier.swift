//
//  CoverBackgroundModifier.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 25.09.2024.
//

import SwiftUI

struct CoverBackgroundModifier: ViewModifier {
    let cover: Cover?
    let heightSize: Double
    
    func body(content: Content) -> some View {
        content
            .background(
                Group {
                    if let cover = cover, cover.enabled {
                        if let largestCoverImage = cover.images.max(by: { $0.width ?? 0 < $1.width ?? 0 }) {
                            AsyncImage(url: largestCoverImage.url) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxHeight: CGFloat(heightSize))
                                    .ignoresSafeArea(edges: .all)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
            )
    }
}

extension View {
    func coverBackground(cover: Cover?, heightSize: Double) -> some View {
        self.modifier(CoverBackgroundModifier(cover: cover, heightSize: heightSize))
    }
}
