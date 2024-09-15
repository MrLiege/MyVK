//
//  AlertView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 15.09.2024.
//

import SwiftUI

struct AlertView: View {
    var message: String
    var retry: VoidAction
    
    var body: some View {
        VStack {
            Text("Ошибка")
                .font(.title)
                .padding()
            
            Text(message)
                .font(.body)
                .padding()
            
            Button(action: {
                retry()
            }) {
                Text("Обновить")
                    .frame(width: 280, height: 50)
                    .background(Color.vkButtonColor)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .cornerRadius(20)
            }
            
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .shadow(radius: 10)
    }
}

#Preview {
    AlertView(message: "Ошибка") {
        print("Retry")
    }
}
