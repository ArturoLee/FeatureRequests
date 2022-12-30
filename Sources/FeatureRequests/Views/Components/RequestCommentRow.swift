//
//  RequestCommentRow.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/12/21.
//

import SwiftUI

struct RequestCommentRow: View {
    
    @EnvironmentObject var service: FeatureRequestService
    @Binding var request: FRequest
    var comment: FeatureRequestComment
    
    var canDelete: Bool {
        return comment.userId == service.user?.id || service.isAdmin
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                if let name = comment.username {
                    Text(name).font(.footnote).foregroundColor(.secondary)
                }
                Spacer()
                if canDelete {
                    Image(systemName: "trash").imageScale(.small).foregroundColor(.secondary).onTapGesture {
                        delete()
                    }
                }
                Text(DateFormatter.localizedString(from: comment.date, dateStyle: .short, timeStyle: .none)).foregroundColor(.secondary)
                    .font(.footnote)
            }
            Text(comment.text).font(.body)
        }
    }
    
    private func delete() {
        service.api.delete(comment: comment, from: request)
        request.comments.removeAll(where: {$0 == comment})
    }
}
//
//struct RequestCommentRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestCommentRow(comment: ExampleComment(username: "ArturoLee", text: "This is a great ide atgqer gqergq regqer gqer gqer gqergqergq ergqerg qergeqrg", date: Date())).environmentObject(ExampleBackendService())
//    }
//}
