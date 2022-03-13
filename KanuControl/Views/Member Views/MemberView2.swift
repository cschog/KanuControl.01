//
//  MemberView2.swift
//  KanuControl
//
//  Created by Christoph Schog on 13.03.22.
//

import SwiftUI
import GRDBQuery

struct MemberView2: View {
    
    @Environment(\.appDatabase) private var appDatabase
    
    /// The `member` property is automatically updated when the database changes
    @Query(MemberInfoRequest()) private var members: [MemberInfo]
    
    @Binding var isPresented: Bool
    
    /// Tracks the presentation of the member creation sheet.
    @State private var newMemberIsPresented = false
    
    var body: some View {
        Text("MemberView!").onAppear {
            //members = try! appDatabase.readAllMemberWithClub()
            for member in members {
                print (member.member.name, member.member.firstName ?? "", member.club?.shortcut ?? "")
            }
        }
    }
}

//struct MemberView2_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberView2()
//    }
//}
