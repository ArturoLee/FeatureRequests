//
//  ContentView.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/12/21.
//

import SwiftUI

public struct FeatureRequests: View {
    
    @StateObject var service: FeatureRequestService
    @State var showingNewRequest = false
    @State var showingRequest = false
    let tintColor: Color
    
    public init(adapter: FeatureRequestsAdapter, user: FeatureRequestUser? = nil, tintColor: Color = Color.accentColor) {
        _service = StateObject(wrappedValue: FeatureRequestService(adapter: adapter, user: user))
        self.tintColor = tintColor
    }
    
    public var body: some View {
        NavigationView {
            List($service.feed) { request in
                NavigationLink {
                    RequestDetails(request: request)
                } label: {
                    RequestRow(request: request)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Feature Requests")
            .navigationBarItems(trailing:
                Button(action: {
                    showingNewRequest = true
                }, label: {
                    Image(systemName: "plus").imageScale(.large)
                }).disabled(!service.userSignedIn)
            )
            .sheet(isPresented: $showingNewRequest, content: {
                NewFeatureRequest(isPresented: $showingNewRequest)
                    .accentColor(tintColor)
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(service)
        .accentColor(tintColor)
        .onAppear { service.getFeatureRequests()}
    }
}
//
//struct FeatureRequests_Previews: PreviewProvider {
//    static var previews: some View {
//        FeatureRequests()
//        .preferredColorScheme(.dark)
//        .previewDevice("iPhone 12 Pro")
//    }
//}
