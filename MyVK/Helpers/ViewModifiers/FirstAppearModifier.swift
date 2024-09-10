//
//  FirstAppearModifier.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 09.09.2024.
//

import SwiftUI

struct FirstAppearModifier: ViewModifier {
    
    @State private var isFirstAppear = true
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard isFirstAppear else { return }
                defer { isFirstAppear = false  }
                action()
            }
    }
}

extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(FirstAppearModifier(action: action))
    }
}
