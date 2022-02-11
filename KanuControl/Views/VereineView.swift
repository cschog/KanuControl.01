//
//  VereineView.swift
//  KanuControl
//
//  Created by Christoph Schog on 09.02.22.
//

import SwiftUI

struct VereineView: View {
    var body: some View {
        List {
            NavigationLink("Club 1", destination: Text("Club 1 Detail View"))
        }
        .navigationBarTitle("Clubs")
    }
}

struct VereineView_Previews: PreviewProvider {
    static var previews: some View {
        VereineView()
    }
}
