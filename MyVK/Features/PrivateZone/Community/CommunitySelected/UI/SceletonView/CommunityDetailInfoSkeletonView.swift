//
//  CommunityDetailInfoSkeletonView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 25.09.2024.
//

import SwiftUI

struct CommunityDetailInfoSkeletonView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 12) {
                ShimmerView()
                    .frame(height: 20)
                    .cornerRadius(4)
                
                ShimmerView()
                    .frame(height: 20)
                    .cornerRadius(4)
                
                ShimmerView()
                    .frame(height: 20)
                    .cornerRadius(4)
            }
            
            Divider()
                .background(Color(.systemGray2))
            
            VStack(alignment: .leading, spacing: 12) {
                ShimmerView()
                    .frame(height: 20)
                    .cornerRadius(4)
                
                ShimmerView()
                    .frame(height: 20)
                    .cornerRadius(4)
                
                ShimmerView()
                    .frame(height: 20)
                    .cornerRadius(4)
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(15)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CommunityDetailInfoSkeletonView()
}
