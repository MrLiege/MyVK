//
//  TextInfoView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 14.09.2024.
//

import SwiftUI

struct TextInfoView: View {
    let title: String
    let value: String
    
    var body: some View {
        Text(title + " ")
            .font(.caption)
            .foregroundStyle(Color.gray)
            .bold()
        +
        Text(value)
            .font(.caption)
            .foregroundStyle(Color.gray)
    }
}

#Preview {
    TextInfoView(title: "Дата", value: "01.01.01")
}
