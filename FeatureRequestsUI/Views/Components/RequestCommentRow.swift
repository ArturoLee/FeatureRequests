//
//  RequestCommentRow.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/12/21.
//

import SwiftUI

struct RequestCommentRow: View {
    
    @EnvironmentObject var backendService: ExampleBackendService
    var comment: ExampleComment
    
    var canDelete: Bool {
        return comment.userDisplayName == backendService.signedInUser.displayName || backendService.isAdmin
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(comment.userDisplayName).font(.footnote).foregroundColor(.secondary)
                Spacer()
                if canDelete {
                    Image(systemName: "trash").imageScale(.small).foregroundColor(.secondary).onTapGesture {
                        backendService.delete(comment)
                    }
                }
                Text(DateFormatter.localizedString(from: comment.date, dateStyle: .short, timeStyle: .none)).foregroundColor(.secondary)
                    .font(.footnote)
            }
            Text(comment.description).font(.body)
        }
    }
}

struct RequestCommentRow_Previews: PreviewProvider {
    static var previews: some View {
        RequestCommentRow(comment: ExampleComment(description: "This is a great ide atgqer gqergq regqer gqer gqer gqergqergq ergqerg qergeqrg", userDisplayName: "ArturoLee", date: Date())).environmentObject(ExampleBackendService())
    }
}
