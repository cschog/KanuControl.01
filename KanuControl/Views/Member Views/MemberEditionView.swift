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
    
    private let memberInfo: MemberInfo
    @State private var form: MemberForm
    
    init(memberInfo: MemberInfo) {
        self.memberInfo = memberInfo
        self.form = MemberForm(memberInfo)
    }
    
    var body: some View {
        MemberFormView(form: $form)
            .onChange(of: isPresented) { isPresented in
                // Save when back button is pressed
                if !isPresented {
                    var savedMemberInfo = memberInfo
                    form.apply(to: &savedMemberInfo)
                    // Ignore error because I don't know how to cancel the
                    // back button and present the error
                    try? appDatabase.saveMemberInfo(&savedMemberInfo)
                }
            }
    }
}
