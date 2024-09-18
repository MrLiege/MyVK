//
//  OnlineIndicatorView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 14.09.2024.
//

import SwiftUI

struct OnlineIndicatorView: View {

    private let borderColor: Color
    private let fromPhone: Bool
    private let isBig: Bool
    
    init(isBig: Bool, borderColor: Color, fromPhone: Bool) {
        self.isBig = isBig
        self.borderColor = borderColor
        self.fromPhone = fromPhone
    }
    
    var body: some View {
        VStack {
            Circle()
                .fill(borderColor)
                .frame(
                    width: isBig ? 28 : 18,
                    height: isBig ? 28 : 18
                )
                .overlay {
                    if fromPhone {
                        Image(systemName: "iphone.smartbatterycase.gen2")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: isBig ? 22 : 15)
                            .foregroundColor(Color.mint)
                    } else {
                        Circle()
                            .fill(Color.mint)
                            .frame(
                                width: isBig ? 25 : 14,
                                height: isBig ? 25 : 14
                            )
                    }
                }
        }
    }
}

#Preview {
    OnlineIndicatorView(isBig: true, borderColor: .gray, fromPhone: false)
}
