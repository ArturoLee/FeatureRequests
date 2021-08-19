//
//  FeatureRequestsProtocols.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/12/21.
//

import Foundation
import SwiftUI

class ExampleBackendService: ObservableObject {
    
    @Published var requestsFeed: [ExampleRequest] = [
        ExampleRequest(commentCount: 3, status: "Posted", title: "Put display name on main page", description: "Put the name of everyone right next to their post", votesCount: 3),
        ExampleRequest(commentCount: 2, status: "Maybe Later", title: "Have a user picture next to each comment", description: "", votesCount: 12),
        ExampleRequest(commentCount: 5, status: "In Progress", title: "Make project available on Github", description: "", votesCount: 8),
        ExampleRequest(commentCount: 1, status: "Completed", title: "Have a main page with a list of features", description: "", votesCount: 20),
        ExampleRequest(commentCount: 0, status: "Considering", title: "Order features by vote count", description: "", votesCount: 3),
        ExampleRequest(commentCount: 4, status: "Planned", title: "Make text font dynamic", description: "", votesCount: 2)
    ].sorted { $0.votesCount > $1.votesCount }
    
    @Published var commentsFeed: [ExampleComment] = [
        ExampleComment(description: "This is a great idea", userDisplayName: "ArturoLee", date: Date()),
        ExampleComment(description: "I don't think this is a high priority", userDisplayName: "Maria", date: Date())
    ]
    
    @Published var signedInUser = ExampleUser(displayName: "GithubUser", votedList: [])
    
    func submitRequest(_ title: String, _ description: String) {
        let newRequest = ExampleRequest(commentCount: 0, status: "Posted", title: title, description: description, votesCount: 0, postedUserDisplayName: signedInUser.displayName)
        requestsFeed.append(newRequest)
        _ = toggleVote(for: newRequest)
    }
    
    func submitComment(_ comment: String) {
        let newComment = ExampleComment(description: comment, userDisplayName: signedInUser.displayName, date: Date())
        commentsFeed.append(newComment)
    }
    
    func toggleVote(for request: ExampleRequest) -> ExampleRequest? {
        guard let i = feedIndex(for: request) else {return nil}
        if signedInUser.votedList.contains(request.uniqueId) {
            //Unvote
            requestsFeed[i].votesCount -= 1
            signedInUser.votedList.remove(request.uniqueId)
        } else {
            //Vote
            requestsFeed[i].votesCount += 1
            signedInUser.votedList.insert(request.uniqueId)
        }
        return requestsFeed[i]
    }
    
    func delete(_ request: ExampleRequest) {
        guard let i = feedIndex(for: request) else {return}
        requestsFeed.remove(at: i)
    }
    
    func delete(_ comment: ExampleComment) {
        for i in 0..<commentsFeed.count {
            if comment.uniqueId == commentsFeed[i].uniqueId {
                commentsFeed.remove(at: i)
                return
            }
        }
    }
    
    private func feedIndex(for request: ExampleRequest) -> Int? {
        for i in 0..<requestsFeed.count {
            if request.uniqueId == requestsFeed[i].uniqueId {
                return i
            }
        }
        return nil
    }
    
    //MARK: - Admin Exclusive Access
    
    var isAdmin: Bool {
        let adminList: Set<String> = ["GithubUser"]
        return adminList.contains(signedInUser.displayName)
    }
    
    func update(_ request: ExampleRequest) {
        guard let i = feedIndex(for: request) else {return}
        requestsFeed[i] = request
    }

}
