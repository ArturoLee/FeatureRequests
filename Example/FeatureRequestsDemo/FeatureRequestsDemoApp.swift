//
//  FeatureRequestsDemoApp.swift
//  FeatureRequestsDemo
//
//  Created by Arturo Lee on 12/30/22.
//

import SwiftUI
import FeatureRequests

@main
struct FeatureRequestsDemoApp: App {
    var body: some Scene {
        WindowGroup {
            FeatureRequests(adapter: ExampleBackendAdapter(), user: FeatureRequestUser(id: "243515", username: "ArturoLee"), tintColor: .green)
        }
    }
}
