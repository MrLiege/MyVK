//
//  OnlineIndicatorView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 14.09.2024.
//

import SwiftUI

struct OnlineIndicatorView: View {

    let borderColor: Color
    let fromPhone: Bool
    
    var body: some View {
        VStack {
            Circle()
                .fill(borderColor)
                .frame(width: 20, height: 20)
                .overlay {
                    if fromPhone {
                        Image(systemName: "iphone.smartbatterycase.gen2")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 15)
                            .foregroundColor(Color.mint)
                    } else {
                        Circle()
                            .fill(Color.mint)
                            .frame(width: 16, height: 16)
                    }
                }
        }
    }
}

#Preview {
    OnlineIndicatorView(borderColor: .gray, fromPhone: false)
}
