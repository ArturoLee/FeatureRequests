//
//  EditFeatureRequest.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/18/21.
//

import SwiftUI

struct EditFeatureRequest: View {
    @EnvironmentObject var backendService: ExampleBackendService
    @Binding var isPresented: Bool
    @Binding var request: ExampleRequest
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title"), footer: Text("Briefly describe your request")) {
                    TextEditor(text: $request.title)
                }
                Section(header: Text("Description"), footer: Text("Provide further details and/or include examples.")) {
                    TextEditor(text: $request.description)
                }
            }
            .navigationTitle("Edit Request")
            .navigationBarItems(leading: Button(action: {
                isPresented = false
            }, label: {
                Text("Cancel").fontWeight(.regular)
            }), trailing: Button(action: {
                backendService.update(request)
                isPresented = false
            }, label: {
                Image(systemName: "arrow.up.circle.fill").imageScale(.large)
            }).disabled($request.title.wrappedValue.isEmpty || $request.description.wrappedValue.isEmpty))
        }
    }
}

struct EditFeatureRequest_Previews: PreviewProvider {
    static var previews: some View {
        EditFeatureRequest(isPresented: .constant(true), request: .constant(ExampleRequest(commentCount: 3, status: "Maybe Later", title: "Put display name on main page", description: "Put the name of everyone right next to their post", votesCount: 3)))
            .preferredColorScheme(.dark)
            .environmentObject(ExampleBackendService())
    }
}
