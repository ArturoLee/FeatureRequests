//
//  ContentView.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/12/21.
//

import SwiftUI

struct FeatureRequests: View {
    
    @State private var showingNewRequest = false
    @StateObject var backendService = ExampleBackendService()
    
    var body: some View {
        NavigationView {
            //Use Element Binding Syntax (Xcode 13)
            List(backendService.requestsFeed, id: \.self) { (request) in
                NavigationLink(
                    destination: RequestDetails(request: request),
                    label: {
                        RequestRow(request: request)
                    })
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Feature Requests")
            .navigationBarItems(trailing:
                Button(action: {
                    showingNewRequest = true
                }, label: {
                    Image(systemName: "plus").imageScale(.large)
            }))
            .sheet(isPresented: $showingNewRequest, content: {
                NewFeatureRequest(isPresented: $showingNewRequest)
            })
        }.environmentObject(backendService)
    }
}

struct FeatureRequests_Previews: PreviewProvider {
    static var previews: some View {
        FeatureRequests()
        .preferredColorScheme(.dark)
        .previewDevice("iPhone 12 Pro")
    }
}
