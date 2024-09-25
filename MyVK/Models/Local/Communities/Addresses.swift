//
//  Addresses.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 25.09.2024.
//

import Foundation

struct Addresses: Equatable {
    let isEnabled: Bool
    let mainAddressId: Int?
    let mainAddress: MainAddress?
    let count: Int?
}

struct MainAddress: Equatable {
    let id: Int?
    let additionalAddress: String?
    let address: String?
    let city: City?
    let country: Country?
    let title: String?
    let workInfoStatus: String?
}

struct City: Equatable {
    let id: Int?
    let title: String?
}

struct Country: Equatable {
    let id: Int?
    let title: String?
}

extension Addresses {
    init(from serverAddresses: ServerAddresses) {
        self.isEnabled = serverAddresses.isEnabled ?? false
        self.mainAddressId = serverAddresses.mainAddressId
        self.mainAddress = serverAddresses.mainAddress.map { MainAddress(from: $0) }
        self.count = serverAddresses.count
    }
}

extension MainAddress {
    init(from serverMainAddress: ServerMainAddress) {
        self.id = serverMainAddress.id
        self.additionalAddress = serverMainAddress.additionalAddress.orEmpty
        self.address = serverMainAddress.address.orEmpty
        self.city = serverMainAddress.city.map { City(from: $0) }
        self.country = serverMainAddress.country.map { Country(from: $0) }
        self.title = serverMainAddress.title.orEmpty
        self.workInfoStatus = serverMainAddress.workInfoStatus.orEmpty
    }
}

extension City {
    init(from serverCity: ServerCity) {
        self.id = serverCity.id
        self.title = serverCity.title.orEmpty
    }
}

extension Country {
    init(from serverCountry: ServerCountry) {
        self.id = serverCountry.id
        self.title = serverCountry.title.orEmpty
    }
}
