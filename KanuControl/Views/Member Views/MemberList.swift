//
//  MemberList2.swift
//  KanuControl
//
//  Created by Christoph Schog on 13.03.22.
//

import SwiftUI
import GRDBQuery

struct MemberList: View {
    
    // Write access to the database
    @Environment(\.appDatabase) private var appDatabase
    // @Query(MemberRequest(ordering: .byName)) private var member: [Member]
    
    @State private var showingAlert = false
    @State private var deleteRow = false
    @State private var memberIds: [Int64] = [0]
    var dummy: [Int64] = [1,2]
    
    /// The member in the list
    var memberInfos: [MemberInfo]
    
    
    var body: some View {
        List {
            ForEach(0 ..< memberInfos.count, id: \.self) { value in
                NavigationLink(destination: editionView(for: memberInfos[value])) {
                    MemberInfoRow(memberInfo: memberInfos[value])
                    // Don't animate member update
                        .animation(nil, value: memberInfos[value])
                }
            }
            .onDelete { offsets in
                memberIds =  offsets.compactMap({ value in
                    return memberInfos[value].member.id
                })
                showingAlert = true
            }
            .alert("Wirklich löschen?", isPresented: $showingAlert) {
                Button("OK", role: nil, action: {
                    
                    try! appDatabase.deleteMember(ids: memberIds)
                })
                Button("Cancel", role: .cancel, action: {
                })}
        }
    }
    /// The view that edits a member in the list.
    private func editionView(for memberInfo: MemberInfo) -> some View {
        MemberEditionView(memberInfo: memberInfo).navigationBarTitle(memberInfo.member.fullName)
    }
    
}

private struct MemberInfoRow: View {
    var memberInfo: MemberInfo
    
    var body: some View {
        HStack {
            Text(memberInfo.member.fullName)
            Spacer()
            Text(memberInfo.club?.shortcut ?? "")
        }
    }
}
