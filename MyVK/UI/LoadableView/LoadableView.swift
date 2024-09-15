//
//  LoadableView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 14.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct LoadableView<Content: View, Skeleton: View>: View {
    
    @Bindable var store: StoreOf<LoadableViewFeature>
    let content: () -> Content
    let skeleton: () -> Skeleton
    
    var body: some View {
        Group {
            switch store.screenState {
            case .loading:
                skeleton()
            case .loaded:
                content()
            }
        }
        
        .fullScreenCover(isPresented: $store.isErrorShowing) {
            
            AlertView(message: store.errorMessage ?? "==Возможно какая-то ошибка!==",
                      retry: repeatAction)
        }
    }
}

private extension LoadableView {
    func repeatAction() {
        store.send(.onRepeat)
    }
}

//#Preview {
//    LoadableView()
//}
