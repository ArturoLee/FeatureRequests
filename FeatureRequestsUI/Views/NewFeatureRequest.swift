//
//  NewFeatureRequest.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/13/21.
//

import SwiftUI

struct NewFeatureRequest: View {
    
    @EnvironmentObject var backendService: ExampleBackendService
    @Binding var isPresented: Bool
    @State var title: String = ""
    @State var description: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title"), footer: Text("Briefly describe your request")) {
                    TextEditor(text: $title)
                }
                Section(header: Text("Description"), footer: Text("Provide further details and/or include examples.")) {
                    TextEditor(text: $description)
                }
            }
            .navigationTitle("New Request")
            .navigationBarItems(leading: Button(action: {
                isPresented = false
            }, label: {
                Text("Cancel").fontWeight(.regular)
            }), trailing: Button(action: {
                backendService.submitRequest(title, description)
                isPresented = false
            }, label: {
                Image(systemName: "arrow.up.circle.fill").imageScale(.large)
            }).disabled(title.isEmpty || description.isEmpty))
        }
    }
}

struct NewFeatureRequest_Previews: PreviewProvider {
    static var previews: some View {
        NewFeatureRequest(isPresented: .constant(true))
            .preferredColorScheme(.dark)
            .environmentObject(ExampleBackendService())
    }
}
