//
//  ClubFormView.swift
//  KanuControl
//
//  Created by Christoph Schog on 02.03.22.
//

import SwiftUI

/// The Club editing form, embedded in both
/// `ClubCreationView` and `ClubEditionView`.
struct ClubFormView: View {
    @Binding var form: ClubForm
    
    var body: some View {
        List {
            TextField("Name", text: $form.name)
                .accessibility(label: Text("Club Name"))
            TextField("ShortCut", text: $form.shortcut)
                .accessibility(label: Text("ShortCut"))
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct ClubForm {
    var name: String
    var shortcut: String
}

extension ClubForm {
    init(_ club: Club) {
        self.name = club.name
        self.shortcut = club.shortcut ?? ""
    }
    
    func apply(to club: inout Club) {
        club.name = name
        club.shortcut = shortcut
    }
}

struct ClubFormView_Previews: PreviewProvider {
    static var previews: some View {
        ClubFormView(form: .constant(ClubForm(
            name: "",
            shortcut: "")))
    }
}
