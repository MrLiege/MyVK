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
