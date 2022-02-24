//
//  MitgliederView.swift
//  SwiftUI Demo
//
//  Created by Christoph Schog on 08.02.22.
//

import SwiftUI

struct MitgliederView: View {
    
    @ObservedObject var kanuControlBrain = KanuControlBrain()
    
    /// We'll need to leave edit mode in several occasions.
    @State private var editMode = EditMode.inactive
    
    /// Tracks the presentation of the player creation sheet.
    @State private var neuesMitgliedIsPresented = false
    
    var body: some View {
        List (kanuControlBrain.personen){ person in
            NavigationLink(destination: MitgliederDetailView(name: person.name, vorname: person.vorname ?? "")) {
                    if let vorname = person.vorname {
                        Text("\(person.name), \(vorname)")
                }
            }
        }
        .navigationBarTitle(Text("\(kanuControlBrain.personen.count) Mitglieder"))
        .navigationBarItems(
            trailing: HStack {
                EditButton()
                neuesMitgliedButton
            })

    }
    
    // The button that presents the player creation sheet.
    private var neuesMitgliedButton: some View {
        Button {
            stopEditing()
            neuesMitgliedIsPresented = true
        } label: {
            Image(systemName: "plus")
        }
        .accessibility(label: Text("New User"))
        .sheet(isPresented: $neuesMitgliedIsPresented) {
            //UserCreationView()
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
        MitgliederView()
    }
}
