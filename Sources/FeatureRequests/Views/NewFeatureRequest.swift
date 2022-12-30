//
//  NewFeatureRequest.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/13/21.
//

import SwiftUI

struct NewFeatureRequest: View {
    
    @EnvironmentObject var service: FeatureRequestService
    @Binding var isPresented: Bool
    @State var title: String = ""
    @State var details: String = ""

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Title"), footer: Text("Briefly describe your request")) {
                    TextEditor(text: $title)
                }
                Section(header: Text("Description"), footer: Text("Provide further details and/or include examples.")) {
                        TextEditor(text: $details)
                }
            }
            .navigationTitle("New Request")
            .navigationBarItems(leading: Button(action: {
                isPresented = false
            }, label: {
                Text("Cancel").fontWeight(.regular)
            }), trailing: Button(action: {
                service.submitRequest(title, details)
                isPresented = false
            }, label: {
                Image(systemName: "arrow.up.circle.fill").imageScale(.large)
            }).disabled(title.isEmpty || details.isEmpty))
        }
    }
    
}
//
//struct NewFeatureRequest_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFeatureRequest(isPresented: .constant(true))
//            .preferredColorScheme(.dark)
//            .environmentObject(ExampleBackendService())
//    }
//}
