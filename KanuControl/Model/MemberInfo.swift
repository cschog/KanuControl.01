//
//  MemberInfo.swift
//  KanuControl
//
//  Created by Christoph Schog on 08.03.22.
//

import Foundation
import GRDB

struct MemberInfo {
    let member: Member
    let club: Club?
    
    let request = Member.including(optional: Member.club)
//    let memberInfos = MemberInfo.fetchAll(db, request)
}


