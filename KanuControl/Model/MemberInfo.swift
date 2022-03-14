//
//  MemberInfo.swift
//  KanuControl
//
//  Created by Christoph Schog on 08.03.22.
//
//
import Foundation
import GRDB

struct MemberInfo: FetchableRecord, Codable, Equatable  {

    var member: Member
    var club: Club?

}



