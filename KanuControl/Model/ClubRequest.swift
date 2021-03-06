//
//  ClubRequest.swift
//  KanuControl
//
//  Created by Christoph Schog on 03.03.22.
//

import Combine
import GRDB
import GRDBQuery

/// A club request can be used with the `@Query` property wrapper in order to
/// feed a view with a list of clubs.
///
/// For example:
///
///     struct MyView: View {
///         @Query(ClubRequest(ordering: .byName)) private var clubs: [Club]
///
///         var body: some View {
///             List(clubs) { club in ... )
///         }
///     }
struct ClubRequest: Queryable {
    enum Ordering {
        case byName
    }
    
    /// The ordering used by the club request.
    var ordering: Ordering
    
    // MARK: - Queryable Implementation
    
    static var defaultValue: [Club] { [] }
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[Club], Error> {
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
    
    /// This method is not required by Queryable, but it makes it easier
    /// to test ClubRequest.
    func fetchValue(_ db: Database) throws -> [Club] {
        switch ordering {
        case .byName:
            return try Club.all().orderedByClubName().fetchAll(db)
        }
    }
}
