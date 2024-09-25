//
//  SectionsViewModifier.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 25.09.2024.
//

import SwiftUI

struct SectionsViewModifier: ViewModifier {
    let image: String
    let value: String
    
    func body(content: Content) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Image(systemName: image)
                .font(.caption)
                .aspectRatio(contentMode: .fit)
                .symbolRenderingMode(.monochrome)
                .foregroundColor(Color.gray)
            
            Text(value)
                .font(.caption)
                .fontWeight(.thin)
                .foregroundStyle(.black)
        }
    }
}

extension View {
    func sectionsView(image: String, value: String) -> some View {
        self.modifier(SectionsViewModifier(image: image, value: value))
    }
}

