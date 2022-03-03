//
//  MitgliederDetailView.swift
//  KanuControl
//
//  Created by Christoph Schog on 11.02.22.
//

import SwiftUI

struct MemberEditionView: View {

    let name: String
    let vorname: String
    
    var body: some View {
        List {
            Text("Name: \(name)")
            Text("First Name: \(vorname)")
        }
    }
}

struct MitgliederDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MemberEditionView(name: "Schog", vorname: "Chris")
    }
}
