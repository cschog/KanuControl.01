//
//  ClubList.swift
//  KanuControl
//
//  Created by Christoph Schog on 03.03.22.
//

import SwiftUI

struct ClubList: View {
    
    // Write access to the database
    @Environment(\.appDatabase) private var appDatabase
    
    @State private var showingAlert = false
    @State private var deleteRow = false
    @State private var clubsIds: [Int64] = [0]
    
    /// The clubs in the list
    var clubs: [Club]
    
    var body: some View {
        List {
            ForEach(clubs) { club in
                NavigationLink(destination: editionView(for: club)) {
                    ClubRow(club: club)
                    // Don't animate club update
                        .animation(nil, value: club)
                }
            }
            .onDelete { offsets in
                clubsIds = offsets.compactMap { clubs[$0].id }
                showingAlert = true
            }
            .alert("Wirklich löschen?", isPresented: $showingAlert) {
                Button("OK", role: nil, action: {
                    try! appDatabase.deleteClub(ids: clubsIds)
                })
                Button("Cancel", role: .cancel, action: {
                })}
            
        }
        // Animate list updates
        .animation(.default, value: clubs)
        .listStyle(.plain)
    }
    
    /// The view that edits a club in the list.
    private func editionView(for club: Club) -> some View {
        ClubsEditionView(club: club).navigationBarTitle(club.name)
    }
    
}

private struct ClubRow: View {
    var club: Club
    
    var body: some View {
        HStack {
            Text(club.name)
            Spacer()
            Text(club.shortcut ?? "")
        }
    }
}


//struct ClubList_Previews: PreviewProvider {
//    static var previews: some View {
//        ClubList(clubs: club)
//    }
//}
