//
//  VereineView.swift
//  KanuControl
//
//  Created by Christoph Schog on 09.02.22.
//
import GRDBQuery
import SwiftUI

struct ClubsView: View {
    /// Write access to the database
    @Environment(\.appDatabase) private var appDatabase
    
    /// The `clubs` property is automatically updated when the database changes
    @Query(ClubRequest(ordering: .byName)) private var clubs: [Club]
    
    /// We'll need to leave edit mode in several occasions.
    @State private var editMode = EditMode.inactive
    
    /// Tracks the presentation of the club creation sheet.
    @State private var newClubIsPresented = false

    var body: some View {
        NavigationView {
            ClubList(clubs: clubs)
                .navigationBarTitle(Text("\(clubs.count) Clubs"))
                .navigationBarItems(
                    trailing: HStack {
                        EditButton()
                        newClubButton
                    })
                .onChange(of: clubs) { clubs in
                    if clubs.isEmpty {
                        stopEditing()
                    }
                }
                .environment(\.editMode, $editMode)
        }
    }
    
    
    
    // The button that presents the club creation sheet.
    private var newClubButton: some View {
        Button {
            stopEditing()
            newClubIsPresented = true
        } label: {
            Image(systemName: "plus")
        }
        .accessibility(label: Text("New Club"))
        .sheet(isPresented: $newClubIsPresented) {
            ClubCreationView()
        }
    }
    
    private func stopEditing() {
        withAnimation {
            editMode = .inactive
        }
    }
}

//struct VereineView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClubsList(clubs: Club)
//    }
//}
