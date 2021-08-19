//
//  RequestDetails.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/12/21.
//

import SwiftUI

struct RequestDetails: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var backendService: ExampleBackendService
    @State var request: ExampleRequest
    @State var newCommentText: String = ""
    
    @State private var showingEditRequest = false
    
    var canDelete: Bool {
        if request.postedUserDisplayName == backendService.signedInUser.displayName && request.votesCount < 2 {
            return true
        } else if backendService.isAdmin {
            return true
        }
        return false
    }
    
    var statusOptions = ["Planned", "In Progress","Completed","Maybe Later","Considering","Posted"]
    
    func update(_ status: String) {
        request.status = status
        backendService.update(request)
    }
    
    func refreshRequest(_ updatedRequest: ExampleRequest) {
        request = updatedRequest
    }
    
    var body: some View {
        List {
            Section(footer:
                HStack {
                    Spacer()
                    Text(DateFormatter.localizedString(from: request.date, dateStyle: .medium, timeStyle: .none)+" by "+request.postedUserDisplayName)
                }
            ) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(request.title).font(.headline)
                            if request.description != "" {
                                Text(request.description).font(.subheadline)
                            }
                            Menu {
                                ForEach(statusOptions, id: \.self) { status in
                                    Button(action: {
                                        update(status)
                                    }, label: {
                                        Text(status)
                                    })
                                }
                            } label: {
                                StatusText(status: request.status)
                            }.disabled(!backendService.isAdmin)
                        }
                        Spacer()
                        VStack{
                            Spacer()
                            VoteButton(request: request, voteCompletion: refreshRequest(_:))
                            Spacer()
                        }
                    }
                }.padding(.vertical, 8)
                if backendService.isAdmin {
                    Button("Edit") {
                        showingEditRequest = true
                    }
                }
            }
            Section(header: Label("Comments", systemImage: "bubble.right")) {
                ForEach(backendService.commentsFeed, id: \.self) {comment in
                    RequestCommentRow(comment: comment)
                }
                HStack {
                    TextField("Add a comment", text: $newCommentText)
                    Button(action: {
                        backendService.submitComment(newCommentText)
                        newCommentText = ""
                        //hide keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Image(systemName: newCommentText.isEmpty ? "paperplane" : "paperplane.fill")
                    }).disabled(newCommentText == "")
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Request Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            //show if request belongs to user and there are less than 2 votes
            Button(action: {
                backendService.delete(request)
                presentation.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "trash")
            }).foregroundColor(.red)
            .disabled(!canDelete)
        )
        .sheet(isPresented: $showingEditRequest, content: {
            EditFeatureRequest(isPresented: $showingEditRequest, request: $request)
        })
    }
}

struct RequestDetails_Previews: PreviewProvider {
    static var previews: some View {
        RequestDetails(request: ExampleRequest(commentCount: 3, status: "Maybe Later", title: "Put display name on main page", description: "Put the name of everyone right next to their post", votesCount: 3))
            .previewDevice("iPhone 12").environmentObject(ExampleBackendService())
    }
}
