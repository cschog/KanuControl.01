//
//  MemberRequest.swift
//  KanuControl
//
//  Created by Christoph Schog on 04.03.22.
//

import Combine
import GRDB
import GRDBQuery

struct MemberRequest: Queryable {
    enum Ordering {
        case byName
    }
    
    /// The ordering used by the club request.
    var ordering: Ordering
    
    // MARK: - Queryable Implementation
    
    static var defaultValue: [Member] { [] }
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[Member], Error> {
        // Build the publisher from the general-purpose read-only access
        // granted by `appDatabase.databaseReader`.
        // Some apps will prefer to call a dedicated method of `appDatabase`.
        ValueObservation
            .tracking(fetchValue(_:))
            .publisher(
                in: appDatabase.databaseReader,
                // The `.immediate` scheduling feeds the view right on
                // subscription, and avoids an undesired animation when the
                // application starts.
                scheduling: .immediate)
            .eraseToAnyPublisher()
    }
    
    // This method is not required by Queryable, but it makes it easier
    // to test MemberRequest.
    func fetchValue(_ db: Database) throws -> [Member] {
        switch ordering {
        case .byName:
            return try Member.all().orderedByName().fetchAll(db)
        }
    }
}

