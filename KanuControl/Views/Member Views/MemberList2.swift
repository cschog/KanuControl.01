//
//  MemberList2.swift
//  KanuControl
//
//  Created by Christoph Schog on 13.03.22.
//

import SwiftUI

struct MemberList2: View {
    
    // Write access to the database
    @Environment(\.appDatabase) private var appDatabase
    
    @State private var showingAlert = false
    @State private var deleteRow = false
    @State private var memberIds: [Int64] = [0]
    
    /// The member in the list
    var members: [MemberInfo]
    
    
    var body: some View {
        List {
            ForEach (members member in)
        }
    }
}

//struct MemberList2_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberList2()
//    }
//}
