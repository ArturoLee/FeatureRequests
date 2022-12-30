//
//  EditFeatureRequest.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/18/21.
//

import SwiftUI

struct EditFeatureRequest: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var service: FeatureRequestService
    @Binding var isPresented: Bool
    @Binding var request: FRequest
    @State var title: String = ""
    @State var details: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Title"), footer: Text("Briefly describe your request")) {
                TextEditor(text: $title)
            }
            Section(header: Text("Description"), footer: Text("Provide further details and/or include examples.")) {
                TextEditor(text: $details)
            }
        }
        .onAppear {
            title = request.title
            details = request.details
        }
        .navigationTitle("Edit Request")
        .navigationBarItems(trailing: Button(action: {
            update()
        }, label: {
            Image(systemName: "arrow.up.circle.fill").imageScale(.large)
        }).disabled($request.title.wrappedValue.isEmpty || $request.details.wrappedValue.isEmpty))
    }
    
    func update() {
        request.title = title
        request.details = details
        service.api.update(request)
        presentation.wrappedValue.dismiss()
    }
}
//
//struct EditFeatureRequest_Previews: PreviewProvider {
//    static var previews: some View {
//        EditFeatureRequest(isPresented: .constant(true), request: .constant(ExampleRequest(title: "Make text font dynamic", details: "", status: "Considering", commentCount: 4, votesCount: 2)))
//            .preferredColorScheme(.dark)
//            .environmentObject(ExampleBackendService())
//    }
//}
