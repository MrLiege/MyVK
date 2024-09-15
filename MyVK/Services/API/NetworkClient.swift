//
//  NetworkClient.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 13.09.2024.
//

import ComposableArchitecture
import AsyncNetwork

extension AsyncNetwork: DependencyKey {
    public static let liveValue = AsyncNetwork(
        options: .default,
        eventManager: EventManager(receivers: [NetworkableLogger(systemLogsEnabled: false)]))
}

extension DependencyValues {
    var networkClient: AsyncNetwork {
        get { self[AsyncNetwork.self] }
        set { self[AsyncNetwork.self] = newValue }
    }
}
