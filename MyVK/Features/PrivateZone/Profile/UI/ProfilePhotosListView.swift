//
//  ProfilePhotosListView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 17.09.2024.
//

import SwiftUI

struct ProfilePhotosListView: View {
    
    let models: [UserPhotoSize]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(models) { model in
                    AsyncImage(url: model.url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: Constants.imageStandartSize, height: Constants.imageStandartSize)
                            .clipShape(.rect(cornerRadius: 8))
                    } placeholder: {
                        ProgressView()
                            .frame(width: Constants.imageStandartSize, height: Constants.imageStandartSize)
                    }
                }
            }
        }
    }
}

private enum Constants {
    static let imageStandartSize: Double = 144
}
