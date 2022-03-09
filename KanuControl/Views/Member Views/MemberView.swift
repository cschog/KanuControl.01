//
//  MemberView.swift
//  KanuControl
//
//  Created by Christoph Schog on 08.02.22.
//

import GRDBQuery
import SwiftUI

struct MemberView: View {
    
    @Environment(\.appDatabase) private var appDatabase
    
    /// The `member` property is automatically updated when the database changes
    @Query(MemberRequest(ordering: .byName)) private var members: [Member]

    
    /// We'll need to leave edit mode in several occasions.
    @State private var editMode = EditMode.inactive
    
    /// Tracks the presentation of the member creation sheet.
    @State private var newMemberIsPresented = false
    
    var body: some View {
        NavigationView {
            MemberList(members: members)
                .navigationBarTitle(Text("\(members.count) Member"), displayMode: .inline)
                .navigationBarItems(
                    trailing: HStack {
                        EditButton()
                        newMemberButton
                    })
                .onChange(of: members) { members in
                    if members.isEmpty {
                        stopEditing()
                    }
                }
                .environment(\.editMode, $editMode)
        }
        .navigationViewStyle(.stack)
    }
    
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
    
    private func stopEditing() {
        withAnimation {
            editMode = .inactive
        }
    }
}

struct MitgliederView_Previews: PreviewProvider {
    static var previews: some View {
        MemberView()
    }
}
