//
//  RequestCommentRow.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/12/21.
//

import SwiftUI

struct RequestCommentRow: View {
    var comment: ExampleComment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(comment.userDisplayName).font(.footnote).foregroundColor(.secondary)
                Spacer()
                Text(DateFormatter.localizedString(from: comment.date, dateStyle: .short, timeStyle: .none)).foregroundColor(.secondary)
                    .font(.footnote)
            }
            Text(comment.description).font(.body)
        }
    }
}

struct RequestCommentRow_Previews: PreviewProvider {
    static var previews: some View {
        RequestCommentRow(comment: ExampleComment(description: "This is a great idea", userDisplayName: "ArturoLee", date: Date()))
    }
}
