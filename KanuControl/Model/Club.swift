//
//  Verein.swift
//  KanuControl
//
//  Created by Christoph Schog on 22.02.22.
//

import Foundation
import GRDB

struct Club: Identifiable, Equatable {
    // The club id.
    
    var id: Int64?
    var name: String
    var shortcut: String?
}

// MARK: - Persistence

/// Make Club a Codable Record.
extension Club: Codable, Hashable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    fileprivate enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let shortcut = Column(CodingKeys.shortcut)
    }
    
    /// Updates a club id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
    
}

// MARK: - Associations

//extension Club: TableRecord, EncodableRecord {
extension Club: TableRecord {

    static let member = hasMany(Member.self)

    var member: QueryInterfaceRequest<Member> {
        return request(for: Club.member)
    }
}

// MARK: - Club Database Requests

/// Define some club requests used by the application.
///
/// See <https://github.com/groue/GRDB.swift/blob/master/README.md#requests>

extension DerivableRequest where RowDecoder == Club {
   
    /// A request of clubs ordered by name.
    func orderedByClubName() -> Self {
        // Sort by name in a localized case insensitive fashion
        // See https://github.com/groue/GRDB.swift/blob/master/README.md#string-comparison
        order(Club.Columns.name.collating(.localizedCaseInsensitiveCompare))
    }
}

