//
//  Model.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/14/21.
//

import Foundation

struct ExampleComment: Hashable {
    var description: String
    var userDisplayName: String
    var date: Date
}

struct ExampleRequest: Hashable {
    var uniqueId: Int = Int.random(in: 1...Int.max)
    var commentCount: Int
    var status: String
    var title: String
    var description: String
    var votesCount: Int
    var date: Date = Date()
    var postedUserDisplayName: String = "ArturoLee"
}

struct ExampleUser {
    var displayName: String
    var votedList: Set<Int>
}
