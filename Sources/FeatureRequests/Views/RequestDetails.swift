//
//  RequestDetails.swift
//  FeatureRequestsUI
//
//  Created by Arturo Lee on 8/12/21.
//

import SwiftUI

struct RequestDetails: View {

    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var service: FeatureRequestService
    @Binding var request: FRequest
    @State var newCommentText: String = ""
    @State private var showingEditRequest = false

    var canDelete: Bool {
        if request.postedUserId == service.user?.id {
            return true
        } else if service.isAdmin {
            return true
        }
        return false
    }

    var body: some View {
        List {
            Section(footer:
                HStack {
                    Spacer()
                Text(DateFormatter.localizedString(from: request.date, dateStyle: .medium, timeStyle: .none)+" by "+(request.postedUsername ?? request.postedUserId))
                }
            ) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(request.title).font(.headline)
                            if request.details != "" {
                                Text(request.details).font(.subheadline)
                            }
                            Menu {
                                ForEach(FeatureRequestStatus.allCases, id: \.self) { status in
                                    Button(action: {
                                        update(status)
                                    }, label: {
                                        Text(status.localized)
                                    })
                                }
                            } label: {
                                StatusText(status: request.status)
                            }.disabled(!service.isAdmin)
                        }
                        Spacer()
                        VStack{
                            Spacer()
                            VoteButton(request: $request)
                            Spacer()
                        }
                    }
                }.padding(.vertical, 8)
                if service.api.isAdmin(service.user) {
                    NavigationLink("Edit") {
                        EditFeatureRequest(isPresented: $showingEditRequest, request: $request)
                    }
                }
            }
            Section(header: Label("Comments", systemImage: "bubble.right")) {
                ForEach(request.comments, id: \.self) { comment in
                    RequestCommentRow(request: $request, comment: comment)
                }
                HStack {
                    TextField("Add a comment", text: $newCommentText)
                    Button(action: {
                        submit(newCommentText)
                        newCommentText = ""
                        //hide keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Image(systemName: newCommentText.isEmpty ? "paperplane" : "paperplane.fill")
                    }).disabled(newCommentText == "" || !service.userSignedIn)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Request Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            //Show if request belongs to user and there are less than 2 votes
            Button(action: {
            service.delete(request)
            }, label: {
                Image(systemName: "trash")
            }).foregroundColor(.red)
            .disabled(!canDelete)
        )
        .sheet(isPresented: $showingEditRequest, content: {
            EditFeatureRequest(isPresented: $showingEditRequest, request: $request)
        })
    }
    
    private func update(_ status: FeatureRequestStatus) {
        request.status = status
        service.api.update(request)
    }
    
    private func submit(_ comment: String) {
        guard let user = service.user else {return}
        let frComment = FeatureRequestComment(userId: user.id, username: user.username, text: comment, date: Date())
        service.api.submitComment(frComment, for: request)
        request.comments.append(frComment)
        newCommentText = ""
    }
}

//
//struct RequestDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestDetails(request: ExampleRequest(title: "Make text font dynamic", details: "", status: "Considering", commentCount: 4, votesCount: 2))
//            .previewDevice("iPhone 12").environmentObject(ExampleBackendService())
//    }
//}
