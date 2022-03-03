//
//  VereineView.swift
//  KanuControl
//
//  Created by Christoph Schog on 09.02.22.
//

import SwiftUI

struct ClubsView: View {
    
    @ObservedObject var kanuControlBrain = KanuControlBrain()
    
    /// We'll need to leave edit mode in several occasions.
    @State private var editMode = EditMode.inactive
    
    /// Tracks the presentation of the member creation sheet.
    @State private var neuerVereinIsPresented = false
    
    var body: some View {
        List (kanuControlBrain.vereine){ verein in
            NavigationLink(destination: ClubsDetailView(name: verein.name, kurz: verein.shortcut ?? "")) {
                    if let kurz = verein.shortcut {
                        Text("\(verein.name), \(kurz)")
                }
            }
        }
        .navigationBarTitle(Text("\(kanuControlBrain.vereine.count) Clubs"))
        .navigationBarItems(
            trailing: HStack {
                EditButton()
                neuerVereinButton
            })

    }
    
    // The button that presents the verein creation sheet.
    private var neuerVereinButton: some View {
        Button {
            stopEditing()
            neuerVereinIsPresented = true
        } label: {
            Image(systemName: "plus")
        }
        .accessibility(label: Text("New Club"))
        .sheet(isPresented: $neuerVereinIsPresented) {
            ClubCreationView()
        }
    }
    
    private func stopEditing() {
        withAnimation {
            editMode = .inactive
        }
    }
}

struct VereineView_Previews: PreviewProvider {
    static var previews: some View {
        ClubsView()
    }
}
