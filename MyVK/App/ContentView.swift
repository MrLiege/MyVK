//
//  ContentView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 03.09.2024.
//

import SwiftUI
import UIKit
import ComposableArchitecture

struct ContentView: View {
    
    @State private var isAuthorized: Bool = UserStorage.shared.token == nil
    
    var body: some View {
        Group {
            if isAuthorized, let url = AuthURLBuilder.current.url {
                AuthWebView(authURL: url)
            } else {
                TabBarView(
                    store: Store(
                        initialState: TabBarFeature.State(),
                        reducer: {
                            TabBarFeature()
                        }
                    )
                )
                .onFirstAppear(perform: setupTabBar)
                .debugPrint("TabBarView appears")
            }
        }
        .debugPrint("ContentView appears")
        .onChange(of: UserStorage.shared.token) { _, newValue in
            isAuthorized = newValue != nil
        }
    }
}

private extension ContentView {
    func setupTabBar() {
        UITabBar.appearance().unselectedItemTintColor = .black
    }
}

#Preview {
    ContentView()
}
