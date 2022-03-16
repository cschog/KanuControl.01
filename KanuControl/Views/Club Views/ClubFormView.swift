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
            Group {
                TextField("Name", text: $form.name)
                    .accessibility(label: Text("Club Name"))
                    .keyboardType(.alphabet)
                    .disableAutocorrection(true)
                TextField("ShortCut", text: $form.shortcut)
                    .accessibility(label: Text("ShortCut"))
                TextField("Street", text: $form.street)
                    .accessibility(label: Text("Street"))
                TextField("zipCode", text: $form.zipCode)
                    .accessibility(label: Text("zipCode"))
                TextField("City", text: $form.city)
                    .accessibility(label: Text("City"))
                TextField("Phone", text: $form.phone)
                    .accessibility(label: Text("Phone"))
            }
            Group {
                TextField("Bankname", text: $form.bankName)
                    .accessibility(label: Text("Bankname"))
                TextField("IBAN", text: $form.iban)
                    .accessibility(label: Text("IBAN"))
                TextField("BIC", text: $form.bic)
                    .accessibility(label: Text("BIC"))
                TextField("Account Holder", text: $form.accountHolder)
                    .accessibility(label: Text("Accountholder"))
                TextField("Account Holder Adress", text: $form.accountHolderAdress)
                    .accessibility(label: Text("AccountholderAdress"))
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct ClubForm {
    var name: String
    var shortcut: String
    var street: String
    var zipCode: String
    var city: String
    var phone: String
    var iban: String
    var bic: String
    var bankName: String
    var accountHolder: String
    var accountHolderAdress: String
}

extension ClubForm {
    init(_ club: Club) {
        self.name = club.name
        self.shortcut = club.shortcut
        self.street = club.street
        self.zipCode = club.zipCode
        self.city = club.city
        self.phone = club.phone
        self.iban = club.iban
        self.bic = club.bic
        self.bankName = club.bankName
        self.accountHolder = club.accountHolder
        self.accountHolderAdress = club.accountHolderAdress
    }
    
    func apply(to club: inout Club) {
        club.name = name
        club.shortcut = shortcut
        club.street = street
        club.zipCode = zipCode
        club.city = city
        club.phone = phone
        club.iban = iban
        club.bic = bic
        club.bankName = bankName
        club.accountHolder = accountHolder
        club.accountHolderAdress = accountHolderAdress
    }
}

//struct ClubFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClubFormView(form: .constant(ClubForm(
//            name: "",
//            shortcut: "")))
//    }
//}
