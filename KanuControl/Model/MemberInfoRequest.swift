//
//  MemberInfoRequest.swift
//  KanuControl
//
//  Created by Christoph Schog on 11.03.22.
//

import Combine
import GRDB
import GRDBQuery

struct MemberInfoRequest: Queryable {
    
//    enum Ordering {
//        case byName
//    }
//    
//    /// The ordering used by the club request.
//    var ordering: Ordering
    
    // MARK: - Queryable Implementation
    
    static var defaultValue: [MemberInfo] { [] }
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[MemberInfo], Error> {
        ValueObservation
            .tracking(fetchValue(_:))
            .publisher(
                in: appDatabase.databaseReader,
                scheduling: .immediate)
            .eraseToAnyPublisher()
    }
    
    // This method is not required by Queryable, but it makes it easier
    // to test MemberRequest.
    func fetchValue(_ db: Database) throws -> [MemberInfo] {
        let request = Member.including(optional: Member.club).orderedByName()
        return try MemberInfo.fetchAll(db, request)
    }
    
}

