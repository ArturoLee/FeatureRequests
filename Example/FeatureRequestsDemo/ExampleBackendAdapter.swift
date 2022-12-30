//
//  ExampleBackendAdapter.swift
//  FeatureRequestsDemo
//
//  Created by Arturo Lee on 12/30/22.
//

import Foundation
import FeatureRequests

struct ExampleBackendAdapter: FeatureRequestsAdapter {
    
    func getFeatureRequestUser() -> FeatureRequestUser? {
        return FeatureRequestUser(id: "2431513", username: "ArturoLee")
    }
    
    func isAdmin(_ user: FeatureRequestUser?) -> Bool {
        return true
    }
    
    func getFeatureRequests() async -> [FRequest] {
        return [
            FRequest(title: "Put display name on main page", details: "Put the name of everyone right next to their post", votedUserIds: ["qrgegqre","qregqergqe","qergqrg"], postedUsername: "ArturoLee", postedUserId: "qregq", status: "Posted", date: Date(), comments: []),
            FRequest(title: "Have a user picture next to each comment", details: "", votedUserIds: ["qrgegqre","qregqergqe","qergqrg"], postedUsername: "ArturoLee", postedUserId: "qregq", status: "Maybe Later", date: Date(), comments: []),
            FRequest(title: "Make project available on Github", details: "", votedUserIds: ["qrgegqre","qregqergqe","qergqrg"], postedUsername: "ArturoLee", postedUserId: "qregq", status: "In Progress", date: Date(), comments: []),
            FRequest(title: "Have a main page with a list of features", details: "", votedUserIds: ["qrgegqre","qregqergqe","qergqrg"], postedUsername: "ArturoLee", postedUserId: "qregq", status: "Completed", date: Date(), comments: []),
            FRequest(title: "Make text font dynamic", details: "", votedUserIds: ["qrgegqre","qregqergqe","qergqrg"], postedUsername: "ArturoLee", postedUserId: "qregq", status: "Considering", date: Date(), comments: [])
        ]
    }
    
    func submit(_ request: FRequest) {
        
    }
    
    func delete(featureRequest: FRequest) {
        
    }
    
    func update(_ request: FRequest) {
        
    }
    
    func toggleVote(to: Bool, for request: FRequest) {
        
    }
    
    func submitComment(_ comment: FeatureRequestComment, for: FRequest) {
        
    }
    
    func delete(comment: FeatureRequestComment, from: FRequest) {
        
    }
    
//    var storedInMemory: [FRequest] = [
//        FRequest(title: "Put display name on main page", details: "Put the name of everyone right next to their post", votedUserIds: ["qrgegqre","qregqergqe","qergqrg"], postedUserId: "qregq", status: "Posted", date: Date(), comments: [])
//        FeatureRequest(
//        FeatureRequest(title: "Put display name on main page", details: "Put the name of everyone right next to their post", status: "Posted"),
//        FeatureRequest(title: "Have a user picture next to each comment", details: "", status: "Maybe Later", commentCount: 5, votesCount: 12),
//        FeatureRequest(title: "Make project available on Github", details: "", status: "In Progress", commentCount: 5, votesCount: 8),
//        FeatureRequest(title: "Have a main page with a list of features", details: "", status: "Completed", commentCount: 0, votesCount: 20),
//        FeatureRequest(title: "Order features by vote count", details: "", status: "Considering", commentCount: 0, votesCount: 3),
//        FeatureRequest(title: "Make text font dynamic", details: "", status: "Considering", commentCount: 4, votesCount: 2)
//    ]
    
}
//struct ExampleBackendAPI: FeatureRequestsAPI {
//
//    func getFeatureRequestUser() -> FeatureRequestUser? {
//        nil
//    }
//
//    func isAdmin() -> Bool {
//        return true
//    }
//
//    func getFeatureRequests() async -> [FeatureRequests] {
//        return []
//    }
//
//    func submit(_ request: FeatureRequest) {
//        <#code#>
//    }
//
//    func delete(featureRequest: FeatureRequest) {
//        <#code#>
//    }
//
//    func update(_ request: FeatureRequest) {
//        <#code#>
//    }
//
//    func vote(for request: FeatureRequest) {
//        <#code#>
//    }
//
//    func submitComment(_ comment: FeatureRequestComment, for: FeatureRequest) {
//        <#code#>
//    }
//
//    func delete(comment: FeatureRequestComment, from: FeatureRequest) {
//        <#code#>
//    }
//
//
//}
