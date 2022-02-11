//
//  MitgliederView.swift
//  SwiftUI Demo
//
//  Created by Christoph Schog on 08.02.22.
//

import SwiftUI

struct MitgliederView: View {
    var body: some View {
        List {
            NavigationLink("Member 1", destination: Text("Member 1 Detail View"))
        }
        .navigationBarTitle("Member")
    }
}

struct MitgliederView_Previews: PreviewProvider {
    static var previews: some View {
        MitgliederView()
    }
}
