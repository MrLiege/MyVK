//
//  ProfileSceletonView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 18.09.2024.
//

import SwiftUI

struct ProfileSceletonView: View {
    var body: some View {
        VStack(spacing: 16) {
            profileInfoSceleton
            friendsListSceleton
            photosListSceleton
        }
        .padding(.vertical, 100)
        
        Spacer()    
    }
}

private extension ProfileSceletonView {
    // MARK: Info profile
    @ViewBuilder
    var profileInfoSceleton: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                ShimmerView()
                    .frame(width: Constants.imageStandartSize, height: Constants.imageStandartSize)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 2)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                ShimmerView()
                    .frame(height: 24)
                    .cornerRadius(4)
                    .shadow(radius: 2)
                
                ShimmerView()
                    .cornerRadius(16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .cornerRadius(12)
            }
            .frame(maxHeight: Constants.imageStandartSize)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(white: 0.95))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
    // MARK: Friends with photo
    @ViewBuilder
    var friendsListSceleton: some View {
        VStack(alignment: .leading) {
            ShimmerView()
                .frame(width: UIScreen.main.bounds.size.width / 5, height: 24)
                .cornerRadius(4)
                .shadow(radius: 2)
            
            Divider()
                .background(Color(.systemGray2))
            
            HStack(spacing: 4) {
                ForEach(0..<6) { _ in
                    ShimmerView()
                        .frame(width: Constants.imageSmall, height: Constants.imageSmall)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                    
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(white: 0.95))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
    // MARK: Profile's photos
    @ViewBuilder
    var photosListSceleton: some View {
        VStack(alignment: .leading) {
            ShimmerView()
                .frame(width: UIScreen.main.bounds.size.width / 5, height: 24)
                .cornerRadius(4)
                .shadow(radius: 2)
            
            Divider()
                .background(Color(.systemGray2))
            
            HStack(spacing: 4) {
                ForEach(0..<2) { _ in
                    ShimmerView()
                        .frame(width: Constants.imageStandartSize, height: Constants.imageStandartSize)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 2)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(white: 0.95))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

private enum Constants {
    static let imageSmall: Double = 54
    static let imageStandartSize: Double = 144
}


#Preview {
    ProfileSceletonView()
}
