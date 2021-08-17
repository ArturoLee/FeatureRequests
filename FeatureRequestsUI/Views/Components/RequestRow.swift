//
//  RequestRow.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/12/21.
//

import SwiftUI

struct RequestRow: View {
    
    var request: ExampleRequest
    
    var body: some View {
        HStack(spacing: 15) {
            VoteButton(request: request)
            VStack(alignment: .leading, spacing: 8) {
                Text(request.title)
                    .lineLimit(2)
                HStack {
                    StatusText(status: request.status)
                    Spacer()
                    if request.commentCount > 0 {
                        Image(systemName: "text.bubble").imageScale(.small).foregroundColor(.secondary)
                        Text("\(request.commentCount)").font(.subheadline).foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct RequestRow_Previews: PreviewProvider {
    static var previews: some View {
        RequestRow(request: ExampleRequest(commentCount: 5, status: "Posted", title: "I want the app to have a section for feature requests", description: "", votesCount: 6))
            .previewDevice("iPhone 12 Pro Max")
    }
}
