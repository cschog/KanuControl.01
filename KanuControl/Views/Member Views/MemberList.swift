//
//  MemberList.swift
//  KanuControl
//
//  Created by Christoph Schog on 04.03.22.
//

import SwiftUI

struct MemberList: View {
    
    // Write access to the database
    @Environment(\.appDatabase) private var appDatabase
    
    @State private var showingAlert = false
    @State private var deleteRow = false
    @State private var memberIds: [Int64] = [0]
    var dummy: [Int64] = [1,2]
    
    /// The member in the list
    @State private var members: [Member]
    
    var body: some View {
        List {
            ForEach(members) { member in
                NavigationLink(destination: editionView(for: member)) {
                    MemberRow(member: member)
                    // Don't animate member update
                        .animation(nil, value: member)
                }
            }
            .onDelete { offsets in
            memberIds =  dummy // offsets.compactMap { memberInfos[$0].id }
                showingAlert = true
            }
            .alert("Wirklich löschen?", isPresented: $showingAlert) {
                Button("OK", role: nil, action: {
                    print ("delete Member")
//                    try! appDatabase.deleteMember(ids: memberIds)
                })
                Button("Cancel", role: .cancel, action: {
                })}
            
        }
        // Animate list updates
        .animation(.default, value: members)
        .listStyle(.plain)
    }
    
    /// The view that edits a member in the list.
    private func editionView(for member: Member) -> some View {
        MemberEditionView(member: member).navigationBarTitle(member.name)
    }
}

private struct MemberRow: View {
    var member: Member
    
    var body: some View {
        HStack {
            Text(member.name)
            Spacer()
            Text(member.firstName ?? "")
        }
    }
}
