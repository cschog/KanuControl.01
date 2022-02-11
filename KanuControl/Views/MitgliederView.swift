//
//  MitgliederView.swift
//  SwiftUI Demo
//
//  Created by Christoph Schog on 08.02.22.
//

import SwiftUI

struct MitgliederView: View {
    
    @ObservedObject var kanuControlBrain = KanuControlBrain()
    
    var body: some View {
        List (kanuControlBrain.personen){ person in
            NavigationLink(destination: MitgliederDetailView(name: person.name, vorname: person.vorname)) {
                HStack {
                    // Text(String(person.id))
                    Text(person.nameGesamt)
                }
            }
        }
        .navigationBarTitle("Mitglieder")
    }
}

struct MitgliederView_Previews: PreviewProvider {
    static var previews: some View {
        MitgliederView()
    }
}
