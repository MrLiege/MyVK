//
//  ContentView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 03.09.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if UserStorage.shared.token == nil, let url = AuthURLBuilder.current.url {
            AuthWebView(authURL: url)
        }
    }
}

#Preview {
    ContentView()
}
