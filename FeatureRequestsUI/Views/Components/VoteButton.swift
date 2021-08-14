//
//  VoteButton.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/14/21.
//

import SwiftUI

struct VoteButton: View {
    
    @EnvironmentObject var backendService: ExampleBackendService
    var request: ExampleRequest
    
    var voted: Bool {
        return backendService.signedInUser.votedList.contains(request.uniqueId)
    }
    
    var votes: Int {
        return backendService.voteCount(for: request)
    }
    
    var body: some View {
        Button(action: {
            toggleVote()
        }, label: {
            VStack {
                Image(systemName: "arrow.up").font(Font.system(size: 17, weight: .black, design: .rounded))
                Text("\(votes)").font(Font.system(size: 17, weight: .semibold, design: .rounded))
                Text("Votes").font(Font.system(size: 15, weight: .regular, design: .rounded))
            }.frame(width: 70, height: 70, alignment: .center)
            .background(voted ? Color.blue : Color.clear).cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.separator)))
        }).foregroundColor(voted ? .white : .secondary)
        .buttonStyle(PlainButtonStyle())
    }
    
    func toggleVote() {
        backendService.toggleVote(for: request)
    }
    
}
struct VoteButton_Previews: PreviewProvider {
    static var previews: some View {
        VoteButton(request: ExampleRequest(commentCount: 5, status: "Posted", title: "I want the app to have a section for feature requests", description: "", votesCount: 6))
    }
}
