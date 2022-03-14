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
    @State var selectedClub: Club = .emptySelection
    
    private func applySelectedClub () {
        // print (self.selectedClub)
        self.form.clubID = selectedClub.id ?? 0
    }

    var body: some View {
        
        List {
            Section(header: Text("Member")) {
                TextField("Name", text: $form.name)
                    .keyboardType(.alphabet)
                    .disableAutocorrection(true)
                    .accessibility(label: Text("Member Name"))
                TextField("First Name", text: $form.firstName)
                    .disableAutocorrection(true)
                    .accessibility(label: Text("First Name"))
                Text (selectedClub.name)
            }.headerProminence(.increased)

            Section(header: Text("Select a Club")) {
                Picker("Club", selection: $selectedClub) {
                    ForEach(self.clubs.map(ClubPickerItem.init), id: \.club) {
                        Text("\($0.club.name)")
                    }
                } .pickerStyle(MenuPickerStyle())
                    .onChange(of: self.selectedClub) { _ in
                        applySelectedClub()
                            }
                //Text("\($selectedClub.id ?? 0)")

            }.headerProminence(.increased)
           
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct ClubPickerItem {
    let club: Club
}

extension Club {
    static let emptySelection = Club(id: 0, name: "", shortcut: "")
}

struct MemberForm {
    var name: String
    var firstName: String
    var clubID: Int64
}

extension MemberForm {
    init(_ memberInfo: MemberInfo) {
        self.name = memberInfo.member.name
        self.firstName = memberInfo.member.firstName
        self.clubID = memberInfo.club?.id ?? 0
    }
    
    func apply(to memberInfo: inout MemberInfo) {
        memberInfo.member.name = name
        memberInfo.member.firstName = firstName
        memberInfo.member.clubId = clubID
    }
}

//struct MemberFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberFormView(form: .constant(MemberForm(
//            name: "",
//            firstName: "")))
//    }
//}
