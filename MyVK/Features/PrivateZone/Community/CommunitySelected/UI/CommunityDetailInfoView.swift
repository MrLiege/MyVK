//
//  CommunityDetailInfoView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 24.09.2024.
//

import SwiftUI

struct CommunityDetailInfoView: View {
    
    let model: Community
    
    var body: some View {
        firstSection
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(15)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension CommunityDetailInfoView {
    @ViewBuilder
    var firstSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 12) {
                if let name = model.name, !name.isEmpty {
                    Text("").sectionsView(image: "list.clipboard", value: name)
                }
                if let status = model.status, !status.isEmpty {
                    Text("").sectionsView(image: "message", value: status)
                }
                if let description = model.description, !description.isEmpty {
                    Text("").sectionsView(image: "text.justify.leading", value: description)
                }
            }
            
            Divider()
                .background(Color(.systemGray2))
            
            VStack(alignment: .leading, spacing: 12) {
                if let screenName = model.screenName, !screenName.isEmpty {
                    Text("").sectionsView(image: "at", value: screenName)
                }
                if let site = model.site, !site.isEmpty {
                    Text("").sectionsView(image: "globe", value: site)
                }
                if let address = model.addresses?.mainAddress?.address, !address.isEmpty,
                   let city = model.addresses?.mainAddress?.city?.title, !city.isEmpty {
                    Text("").sectionsView(image: "mappin.circle", value: "\(address), \(city)")
                }
            }
        }
    }
}
