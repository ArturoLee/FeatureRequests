//
//  RequestRow.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/12/21.
//

import SwiftUI

struct RequestRow: View {
    
    @Binding var request: FRequest
    
    var body: some View {
        HStack(spacing: 15) {
            VoteButton(request: $request)
            VStack(alignment: .leading, spacing: 8) {
                Text(request.title)
                    .lineLimit(2)
                HStack {
                    StatusText(status: request.status)
                    Spacer()
                    if request.comments.count > 0 {
                        Image(systemName: "text.bubble").imageScale(.small).foregroundColor(.secondary)
                        Text("\(request.comments.count)").font(.subheadline).foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}
//
//struct RequestRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestRow(request: ExampleRequest(title: "Make text font dynamic", details: "", status: "Considering", commentCount: 4, votesCount: 2))
//            .previewDevice("iPhone 12 Pro Max")
//    }
//}
