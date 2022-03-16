//
//  ClubView.swift
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
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ClubList(clubs: clubs)
                .navigationBarTitle(Text("\(clubs.count) Clubs"),
                                    displayMode: .inline)
                .navigationBarItems(
                    leading: HStack {
                        leaveClubsViewButton
                    },
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
        .navigationViewStyle(.stack)
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
    
    // Button to leave the ClubsView
    private var leaveClubsViewButton: some View {
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

//struct ClubsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClubsView()
//    }
//}
