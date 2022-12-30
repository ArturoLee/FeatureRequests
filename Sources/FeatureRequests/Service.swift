//
//  FeatureRequestsProtocols.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/12/21.
//

import Foundation
import SwiftUI

//class ExampleBackendService: ObservableObject {
//
//    @Published var requestsFeed: [ExampleRequest] = [
//        ExampleRequest(title: "Put display name on main page", details: "Put the name of everyone right next to their post", status: "Posted", commentCount: 3, votesCount: 3),
//        ExampleRequest(title: "Have a user picture next to each comment", details: "", status: "Maybe Later", commentCount: 5, votesCount: 12),
//        ExampleRequest(title: "Make project available on Github", details: "", status: "In Progress", commentCount: 5, votesCount: 8),
//        ExampleRequest(title: "Have a main page with a list of features", details: "", status: "Completed", commentCount: 0, votesCount: 20),
//        ExampleRequest(title: "Order features by vote count", details: "", status: "Considering", commentCount: 0, votesCount: 3),
//        ExampleRequest(title: "Make text font dynamic", details: "", status: "Considering", commentCount: 4, votesCount: 2)
//    ].sorted { $0.votesCount > $1.votesCount }
//
//    @Published var commentsFeed: [ExampleComment] = [
//        ExampleComment(username: "ArturoLee", text: "This is a great idea", date: Date()),
//        ExampleComment(username: "Maria", text: "I don't think this is a high priority", date: Date())
//    ]
//
//    @Published var signedInUser = ExampleUser(displayName: "GithubUser", votedList: [])
//
//    func submitRequest(_ title: String, _ details: String) {
//        let newRequest = ExampleRequest(id: 0, title: "Posted", details: details, postedUsername: "ArturoLee", postedUserId: signedInUser.displayName, status: "Posted", commentCount: 0, votesCount: 1)
//        requestsFeed.append(newRequest)
//        _ = toggleVote(for: newRequest)
//    }
//
//    func submitComment(_ comment: String) {
//        let newComment = ExampleComment(username: signedInUser.displayName, text: comment, date: Date())
//        commentsFeed.append(newComment)
//    }
//
//    func toggleVote(for request: ExampleRequest) -> ExampleRequest? {
//        guard let i = feedIndex(for: request) else {return nil}
//        if signedInUser.votedList.contains(request.id) {
//            //Unvote
//            requestsFeed[i].votesCount -= 1
//            signedInUser.votedList.remove(request.id)
//        } else {
//            //Vote
//            requestsFeed[i].votesCount += 1
//            signedInUser.votedList.insert(request.id)
//        }
//        return requestsFeed[i]
//    }
//
//    func delete(_ request: ExampleRequest) {
//        guard let i = feedIndex(for: request) else {return}
//        requestsFeed.remove(at: i)
//    }
//
//    func delete(_ comment: ExampleComment) {
//        for i in 0..<commentsFeed.count {
//            if comment.userId == commentsFeed[i].userId {
//                commentsFeed.remove(at: i)
//                return
//            }
//        }
//    }
//
//    private func feedIndex(for request: ExampleRequest) -> Int? {
//        for i in 0..<requestsFeed.count {
//            if request.id == requestsFeed[i].id {
//                return i
//            }
//        }
//        return nil
//    }
//
//    //MARK: - Admin Exclusive Access
//
//    var isAdmin: Bool {
//        let adminList: Set<String> = ["GithubUser"]
//        return adminList.contains(signedInUser.displayName)
//    }
//
//    func update(_ request: ExampleRequest) {
//        guard let i = feedIndex(for: request) else {return}
//        requestsFeed[i] = request
//    }
//
//}

public protocol FeatureRequestsAdapter {
    func isAdmin(_ user: FeatureRequestUser?) -> Bool
    
    func getFeatureRequests() async -> [FRequest]
    func submit(_ request: FRequest)
    func delete(featureRequest: FRequest)
    func update(_ request: FRequest)
    func toggleVote(to: Bool, for request: FRequest)

    func submitComment(_ comment: FeatureRequestComment, for: FRequest)
    func delete(comment: FeatureRequestComment, from: FRequest)
}

@MainActor
class FeatureRequestService: ObservableObject {
    
    let api: FeatureRequestsAdapter
    let user: FeatureRequestUser?
    var userSignedIn: Bool { return user != nil }
    var isAdmin: Bool {api.isAdmin(user)}
    
    @Published var feed: [FRequest] = []
    
    init(adapter: FeatureRequestsAdapter, user: FeatureRequestUser?) {
        self.api = adapter
        self.user = user
    }
    
    func getFeatureRequests() {
        Task {feed = await api.getFeatureRequests()}
    }
    
    func submitRequest(_ title: String, _ details: String) {
        guard let user = user else {return}
        let request = FRequest(title: title, details: details, votedUserIds: [user.id], postedUsername: user.username, postedUserId: user.id, status: "Posted", date: Date(), comments: [])
        api.submit(request)
        feed.append(request)
    }
    
    func delete(_ request: FRequest) {
        api.delete(featureRequest: request)
        feed.removeAll {$0 == request}
    }
    
}
