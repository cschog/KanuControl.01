//
//  MemberView2.swift
//  KanuControl
//
//  Created by Christoph Schog on 13.03.22.
//

import SwiftUI
import GRDBQuery

struct MemberView: View {
    
    @Environment(\.appDatabase) private var appDatabase
    
    /// The `member` property is automatically updated when the database changes
    @Query(MemberInfoRequest()) private var memberInfos: [MemberInfo]
    
    @Binding var isPresented: Bool
    
    /// We'll need to leave edit mode in several occasions.
    @State private var editMode = EditMode.inactive
    
    /// Tracks the presentation of the member creation sheet.
    @State private var newMemberIsPresented = false
    
    var body: some View {
        NavigationView {
            MemberList(memberInfos: memberInfos)
                .navigationBarTitle(Text("\(memberInfos.count) Member"), displayMode: .inline)
                .navigationBarItems(
                    leading: HStack {
                        leaveMemberViewButton
                    },
                    trailing: HStack {
                        EditButton()
                        newMemberButton
                    })
                .onChange(of: memberInfos) { members in
                    if members.isEmpty {
                        stopEditing()
                    }
                }
                .environment(\.editMode, $editMode)
        }
        .navigationViewStyle(.stack)
        .navigationBarHidden(true)    }
    
    // The button that presents the member creation sheet.
    private var newMemberButton: some View {
        Button {
            stopEditing()
            newMemberIsPresented = true
        } label: {
            Image(systemName: "plus")
        }
        .accessibility(label: Text("New Member"))
        .sheet(isPresented: $newMemberIsPresented) {
            MemberCreationView()
        }
    }
    // Button to leave the MemberView
    private var leaveMemberViewButton: some View {
        Button("Back") {
            self.isPresented = false
        }
    }
    
    private func stopEditing() {
        withAnimation {
            editMode = .inactive
        }
    }
}

//struct MemberView2_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberView2()
//    }
//}
