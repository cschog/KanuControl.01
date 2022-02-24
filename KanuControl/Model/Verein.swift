//
//  Verein.swift
//  KanuControl
//
//  Created by Christoph Schog on 22.02.22.
//

import Foundation
import GRDB

struct Verein: Identifiable {
    // The verein id.
    
    var id: Int64?
    var name: String
    var kurz: String?
}

extension Verein: Codable, FetchableRecord, MutablePersistableRecord {
    
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
    
}

extension Verein: TableRecord, EncodableRecord {

    static let mitglieder = hasMany(Person.self)

    private enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let kurz = Column(CodingKeys.kurz) 
    }

    var mitglieder: QueryInterfaceRequest<Person> {
        return request(for: Verein.mitglieder)
    }
}
