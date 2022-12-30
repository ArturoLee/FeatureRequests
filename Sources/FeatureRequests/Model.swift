//
//  Model.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/14/21.
//

import Foundation

//struct ExampleComment: Hashable {
//    var userId: String = String(Int.random(in: 1...Int.max))
//    var username: String?
//    var text: String
//    var date: Date
//}

//struct ExampleRequest: Hashable {
//    var id: Int = Int.random(in: 1...Int.max)
//    var title: String
//    var details: String
//    var votedUserIds: [String] = []
//    var postedUsername: String = "ArturoLee"
//    var postedUserId: String = "3267"
//    var status: String
//    var date: Date = Date()
//    var comments: [ExampleComment] = []
//    var commentCount: Int
//    var votesCount: Int
//}

//struct ExampleUser {
//    var displayName: String
//    var votedList: Set<Int>
//}

public struct FeatureRequestUser {
    let id: String
    let username: String?
    
    public init(id: String, username: String?) {
        self.id = id
        self.username = username
    }
}

public struct FRequest: Hashable, Identifiable {
    public var id: String?
    var title: String
    var details: String
    var votedUserIds: [String]
    var postedUsername: String?
    var postedUserId: String
    var status: FeatureRequestStatus
    var date: Date
    var comments: [FeatureRequestComment]
    
    public init(id: String? = UUID().uuidString, title: String, details: String, votedUserIds: [String], postedUsername: String?, postedUserId: String, status: String, date: Date, comments: [FeatureRequestComment]) {
        self.id = id
        self.title = title
        self.details = details
        self.votedUserIds = votedUserIds
        self.postedUsername = postedUsername
        self.postedUserId = postedUserId
        self.status = FeatureRequestStatus(rawValue: status) ?? .posted
        self.date = date
        self.comments = comments
    }
}

public struct FeatureRequestComment: Hashable {
    var userId: String = String(Int.random(in: 1...Int.max))
    var username: String?
    var text: String
    var date: Date
    
    public init(userId: String, username: String? = nil, text: String, date: Date) {
        self.userId = userId
        self.username = username
        self.text = text
        self.date = date
    }
}

public enum FeatureRequestStatus: String, Equatable, CaseIterable {
    case posted = "Posted"
    case planned = "Planned"
    case inProgress = "In Progress"
    case completed = "Completed"
    case maybeLater = "Maybe Later"
    case considering = "Considering"
    
    var localized: String {
        switch self {
        case .posted:
            return NSLocalizedString("Posted", comment: "")
        case .planned:
            return NSLocalizedString("Planned", comment: "")
        case .inProgress:
            return NSLocalizedString("In Progress", comment: "")
        case .completed:
            return NSLocalizedString("Completed", comment: "")
        case .maybeLater:
            return NSLocalizedString("Maybe Later", comment: "")
        case .considering:
            return NSLocalizedString("Considering", comment: "")
        }
    }
}

//protocol FeatureRequestComment: Hashable {
//    var userId: String { get }
//    var username: String? { get }
//    var text: String { get }
//    var date: Date { get }
//}
//
//protocol FeatureRequest: Hashable {
//    var id: String? { get }
//    var title: String { get }
//    var details: String { get }
//    var votedUserIds: [String] { get }
//    var postedUsername: String? { get }
//    var postedUserId: String { get }
//    var status: String { get }
//    var date: Date { get }
//    var comments: [any FeatureRequestComment] { get }
//}
