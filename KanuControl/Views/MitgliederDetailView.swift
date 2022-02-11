//
//  MitgliederDetailView.swift
//  KanuControl
//
//  Created by Christoph Schog on 11.02.22.
//

import SwiftUI

struct MitgliederDetailView: View {

    let name: String
    let vorname: String
    
    var body: some View {
        List {
            Text("Name: \(name)")
            Text("Vorname: \(vorname)")
        }
    }
}

struct MitgliederDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MitgliederDetailView(name: "Schog", vorname: "Chris")
    }
}
