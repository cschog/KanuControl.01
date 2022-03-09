//
//  MemberEditionView.swift
//  KanuControl
//
//  Created by Christoph Schog on 11.02.22.
//

import SwiftUI

// The view that edits an existing member.
struct MemberEditionView: View {
    /// Write access to the database
    @Environment(\.appDatabase) private var appDatabase
    @Environment(\.isPresented) private var isPresented
    private let member: Member
    @State private var form: MemberForm
    
    init(member: Member) {
        self.member = member
        self.form = MemberForm(member)
    }
    
    var body: some View {
        MemberFormView(form: $form)
            .onChange(of: isPresented) { isPresented in
                // Save when back button is pressed
                if !isPresented {
                    var savedMember = member
                    form.apply(to: &savedMember)
                    // Ignore error because I don't know how to cancel the
                    // back button and present the error
                    try? appDatabase.saveMember(&savedMember)
                }
            }
    }
}

//struct MitgliederDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberEditionView()
//    }
//}
