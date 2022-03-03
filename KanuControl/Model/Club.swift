//
//  Verein.swift
//  KanuControl
//
//  Created by Christoph Schog on 22.02.22.
//

import Foundation
import GRDB

struct Club: Identifiable {
    // The verein id.
    
    var id: Int64?
    var name: String
    var shortcut: String?
}

extension Club: Codable, FetchableRecord, MutablePersistableRecord {
    
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
    
}

extension Club: TableRecord, EncodableRecord {

    static let mitglieder = hasMany(Member.self)

    private enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let shortcut = Column(CodingKeys.shortcut) 
    }

    var mitglieder: QueryInterfaceRequest<Member> {
        return request(for: Club.mitglieder)
    }
}
