//
//  MemberCreationView.swift
//  KanuControl
//
//  Created by Christoph Schog on 04.03.22.
//

import SwiftUI

// The view that creates a new member.
struct MemberCreationView: View {
    
    /// Write access to the database
    @Environment(\.appDatabase) private var appDatabase
    @Environment(\.dismiss) private var dismiss
    @State private var form = MemberForm(name: "", firstName: "")
    @State private var errorAlertIsPresented = false
    @State private var errorAlertTitle = ""
    
    var body: some View {
        NavigationView {
            MemberFormView(form: $form)
                .alert(
                    isPresented: $errorAlertIsPresented,
                    content: { Alert(title: Text(errorAlertTitle)) })
                .navigationBarTitle("New Member")
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
            var member = Member(id: nil, name: "", firstName: "")
            form.apply(to: &member)
            try appDatabase.saveMember(&member)
            dismiss()
        } catch {
            errorAlertTitle = (error as? LocalizedError)?.errorDescription ?? "An error occurred"
            errorAlertIsPresented = true
        }
    }
}

struct MemberCreationView_Previews: PreviewProvider {
    static var previews: some View {
        MemberCreationView()
    }
}
