//
//  Person.swift
//  KanuControl
//
//  Created by Christoph Schog on 11.02.22.
//

import Foundation
import GRDB

struct Member: Identifiable, Equatable {
    // The person id.
    
    var id: Int64?
    var name: String
    var firstName: String?
    var clubId: Int64?
}


// MARK: - Persistence

/// Make Member a Codable Record.
///
/// See <https://github.com/groue/GRDB.swift/blob/master/README.md#records>
///
extension Member: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    fileprivate enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let firstName = Column(CodingKeys.firstName)
        static let clubId = Column(CodingKeys.clubId)
    }
    /// Updates a member id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

// MARK: - Associations

extension Member: TableRecord, EncodableRecord {

    static let club = belongsTo(Club.self)

    var club: QueryInterfaceRequest<Club> {
        return request(for: Member.club)
    }
}

// MARK: - Member Database Requests

/// Define some member requests used by the application.
///
/// See <https://github.com/groue/GRDB.swift/blob/master/README.md#requests>
/// See <https://github.com/groue/GRDB.swift/blob/master/Documentation/GoodPracticesForDesigningRecordTypes.md>
extension DerivableRequest where RowDecoder == Member {
    /// A request of several member ordered by name.
    ///
    /// For example:
    ///
    ///     let members: [Member] = try dbWriter.read { db in
    ///         try Member.all().orderedByName().fetchAll(db)
    ///     }
    func orderedByName() -> Self {
        // Sort by name in a localized case insensitive fashion
        // See https://github.com/groue/GRDB.swift/blob/master/README.md#string-comparison
        order(Member.Columns.name.collating(.localizedCaseInsensitiveCompare))
    }
    
//    func allMembers() {
//        let request = Member.including(optional: Member.club)
//        let memberInfos = MemberInfo.fetchAll(db, request)
//    }
    
    /// A request of clubs ordered by age.
    ///
    /// For example:
    ///
//        let clubs: [Club] = try dbWriter.read { db in
//             try Club.all().orderedByScore().fetchAll(db)
//         }
}
