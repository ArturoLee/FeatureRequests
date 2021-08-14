//
//  StatusText.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/14/21.
//

import SwiftUI

struct StatusText: View {
    
    var status: String
    
    var statusColor: Color {
        switch status {
        case "Planned":
            return Color.purple
        case "In Progress":
            return Color.yellow
        case "Completed":
            return Color.green
        case "Maybe Later":
            return Color.orange
        case "Considering":
            return Color.pink
        default:
            return Color.gray
        }
    }

    var body: some View {
        Text(status)
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
        StatusText(status: "Posted")
    }
}
