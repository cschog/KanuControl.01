//
//  MemberFormView.swift
//  KanuControl
//
//  Created by Christoph Schog on 04.03.22.
//

import GRDBQuery
import SwiftUI

/// The Member editing form, embedded in both
/// `MemberCreationView` and `MemberEditionView`.
struct MemberFormView: View {
    
    /// The `clubs` property is automatically updated when the database changes
    @Query(ClubRequest(ordering: .byName)) private var clubs: [Club]
    
    @Binding var form: MemberForm
    @State private var selectedClub: Club = .emptySelection
    
    var body: some View {
        
        List {
            Section(header: Text("Member")) {
                TextField("Name", text: $form.name)
                    .accessibility(label: Text("Member Name"))
                TextField("First Name", text: $form.firstName)
                    .accessibility(label: Text("First Name"))
                Text (selectedClub.name)
            }.headerProminence(.increased)

            Section(header: Text("Select a Club")) {
                Picker("Club", selection: $selectedClub) {
                    ForEach(self.clubs.map(ClubPickerItem.init), id: \.club) {
                        Text("\($0.club.name)")
                    }
                } .pickerStyle(MenuPickerStyle())

            }.headerProminence(.increased)
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct ClubPickerItem {
    let club: Club
}

extension Club {
    static let emptySelection = Club(id: 2, name: "Eschweiler Kanu Club", shortcut: "EKC")
}

struct MemberForm {
    var name: String
    var firstName: String
    var clubID: Int64
}

extension MemberForm {
    init(_ member: Member) {
        self.name = member.name
        self.firstName = member.firstName ?? ""
        self.clubID = member.clubId ?? 0
    }
    
    func apply(to member: inout Member) {
        member.name = name
        member.firstName = firstName
        member.clubId = clubID
    }
}

//struct MemberFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberFormView(form: .constant(MemberForm(
//            name: "",
//            firstName: "")))
//    }
//}
