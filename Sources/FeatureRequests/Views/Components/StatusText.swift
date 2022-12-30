//
//  StatusText.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/14/21.
//

import SwiftUI

struct StatusText: View {
    
    var status: FeatureRequestStatus
    
    var statusColor: Color {
        switch status {
        case .planned:
            return Color.purple
        case .inProgress:
            return Color.yellow
        case .completed:
            return Color.green
        case .maybeLater:
            return Color.orange
        case .considering:
            return Color.pink
        default:
            return Color.gray
        }
    }

    var body: some View {
        Text(status.localized)
            .font(Font.system(.subheadline, design: .rounded))
            .fontWeight(.medium)
            .padding(.horizontal, 5)
            .padding(.vertical, 2)
            .foregroundColor(.white)
            .background(statusColor)
            .cornerRadius(5)
    }
}

struct StatusText_Previews: PreviewProvider {
    static var previews: some View {
        StatusText(status: .posted)
    }
}
