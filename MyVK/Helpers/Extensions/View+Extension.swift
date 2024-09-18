//
//  View+Extension.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 09.09.2024.
//

import SwiftUI

// MARK: - Debug methods

extension View {
    func debugPrint(_ value: String) -> some View {
        #if DEBUG
        onAppear {
            print(value)
        }
        #endif
    }
}

// MARK: - UI methods

extension View {
    func roundedContainer(_ title: String? = nil, isLoading: Bool) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title {
                Text(title)
                    .font(.title2)
                    .foregroundStyle(Color.gray.opacity(0.8))
                
                Divider()
                    .background(Color(.systemGray2))
            }
            
            if isLoading {
                ProgressView()
            } else {
                self
            }
        }
        .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
        .padding()
        .background(Color.mint.opacity(0.05))
        .clipShape(.rect(cornerRadius: 16))
    }
}
