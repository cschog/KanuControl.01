//
//  VereineDetailView.swift
//  KanuControl
//
//  Created by Christoph Schog on 24.02.22.
//

import SwiftUI

struct ClubsDetailView: View {
    
    let name: String
    let kurz: String
    
    var body: some View {
        List {
            Text("Name: \(name)")
            Text("Shortcut: \(kurz)")
        }
    }
}

struct VereineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClubsDetailView(name: "Eschweiler Kanu Club", kurz: "EKC")
    }
}
