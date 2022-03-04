//
//  MemberFormView.swift
//  KanuControl
//
//  Created by Christoph Schog on 04.03.22.
//

import SwiftUI

/// The Member editing form, embedded in both
/// `MemberCreationView` and `MemberEditionView`.
struct MemberFormView: View {
    @Binding var form: MemberForm
    
    var body: some View {
        List {
            TextField("Name", text: $form.name)
                .accessibility(label: Text("Member Name"))
            TextField("First Name", text: $form.firstName)
                .accessibility(label: Text("First Name"))
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct MemberForm {
    var name: String
    var firstName: String
}

extension MemberForm {
    init(_ member: Member) {
        self.name = member.name
        self.firstName = member.firstName ?? ""
    }
    
    func apply(to member: inout Member) {
        member.name = name
        member.firstName = firstName
    }
}

struct MemberFormView_Previews: PreviewProvider {
    static var previews: some View {
        MemberFormView(form: .constant(MemberForm(
            name: "",
            firstName: "")))
    }
}
