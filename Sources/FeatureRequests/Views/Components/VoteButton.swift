//
//  VoteButton.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/14/21.
//

import SwiftUI

struct VoteButton: View {
    
    @EnvironmentObject var service: FeatureRequestService
    @Binding var request: FRequest
    
    var voted: Bool {
        guard let user = service.user else {return false}
        return request.votedUserIds.contains(user.id)
    }
    
    var body: some View {
        Button(action: {
            toggleVote(to: !voted)
        }, label: {
            VStack {
                Image(systemName: "arrow.up").font(Font.system(size: 17, weight: .black, design: .rounded))
                Text("\(request.votedUserIds.count)").font(Font.system(size: 17, weight: .semibold, design: .rounded))
                Text("Votes").font(Font.system(size: 15, weight: .regular, design: .rounded))
            }.frame(width: 70, height: 70, alignment: .center)
            .background(voted ? Color.blue : Color.clear).cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.separator)))
        }).foregroundColor(voted ? .white : .secondary)
        .buttonStyle(PlainButtonStyle())
    }
    
    func toggleVote(to: Bool) {
        guard let user = service.user else {return}
        service.api.toggleVote(to: to, for: request)
        if to == true {
            request.votedUserIds.append(user.id)
        } else {
            request.votedUserIds.removeAll { $0 == user.id }
        }
    }
    
}
//struct VoteButton_Previews: PreviewProvider {
//    static var previews: some View {
//        VoteButton(request: ExampleRequest(title: "Make text font dynamic", details: "", status: "Considering", commentCount: 4, votesCount: 2))
//    }
//}
