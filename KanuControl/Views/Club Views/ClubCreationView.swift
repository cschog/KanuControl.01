//
//  ClubCreationView.swift
//  KanuControl
//
//  Created by Christoph Schog on 02.03.22.
//

import SwiftUI

/// The view that creates a new club.
struct ClubCreationView: View {
    
    /// Write access to the database
    @Environment(\.appDatabase) private var appDatabase
    @Environment(\.dismiss) private var dismiss
    @State private var form = ClubForm(name: "", shortcut: "")
    @State private var errorAlertIsPresented = false
    @State private var errorAlertTitle = ""
    
    var body: some View {
        NavigationView {
            ClubFormView(form: $form)
                .alert(
                    isPresented: $errorAlertIsPresented,
                    content: { Alert(title: Text(errorAlertTitle)) })
                .navigationBarTitle("New Club")
                .navigationBarItems(
                    leading: Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    },
                    trailing: Button {
                        save()
                    } label: {
                        Text("Save")
                    })
        }
    }
    
    private func save() {
        do {
            var club = Club(id: nil, name: "", shortcut: "")
            form.apply(to: &club)
            try appDatabase.saveClub(&club)
            dismiss()
        } catch {
            errorAlertTitle = (error as? LocalizedError)?.errorDescription ?? "An error occurred"
            errorAlertIsPresented = true
        }
    }
}

struct VereinCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ClubCreationView()
    }
}
