//
//  Person.swift
//  KanuControl
//
//  Created by Christoph Schog on 11.02.22.
//

import Foundation
import GRDB

struct Member: Identifiable, Equatable, Hashable {
    // The person id.
    
    var id: Int64?
    var name: String
    var firstName: String
    var fullName: String {
        return name + ", " + firstName
    }
    var birthday: String
    var sex: String
    var street: String
    var zipCode: String
    var city: String
    var phone: String
    var mobile: String
    var email: String
    var active: Bool
    var activeDate: String
    var bankName: String
    var iban: String
    var bic: String
    var clubId: Int64?
}


// MARK: - Persistence

/// Make Member a Codable Record.

extension Member: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    fileprivate enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let firstName = Column(CodingKeys.firstName)
        static let birthday = Column(CodingKeys.birthday)
        static let sex = Column(CodingKeys.sex)
        static let street = Column(CodingKeys.street)
        static let zipCode = Column(CodingKeys.zipCode)
        static let city = Column(CodingKeys.city)
        static let phone = Column(CodingKeys.phone)
        static let mobile = Column(CodingKeys.mobile)
        static let email = Column(CodingKeys.email)
        static let active = Column(CodingKeys.active)
        static let activeDate = Column(CodingKeys.activeDate)
        static let bankName = Column(CodingKeys.bankName)
        static let iban = Column(CodingKeys.iban)
        static let bic = Column(CodingKeys.bic)
        static let clubId = Column(CodingKeys.clubId)
    }
    /// Updates a member id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

// MARK: - Associations

//extension Member: TableRecord, EncodableRecord {
extension Member  {
    
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
    
    func orderedByName() -> Self {
        // Sort by name in a localized case insensitive fashion
        // See https://github.com/groue/GRDB.swift/blob/master/README.md#string-comparison
        order(Member.Columns.name.collating(.localizedCaseInsensitiveCompare))
    }
}
