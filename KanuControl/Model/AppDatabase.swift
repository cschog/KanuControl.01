import Combine
import Foundation
import GRDB

/// AppDatabase lets the application access the database.
///
/// It applies the pratices recommended at
/// <https://github.com/groue/GRDB.swift/blob/master/Documentation/GoodPracticesForDesigningRecordTypes.md>
struct AppDatabase {
    /// Creates an `AppDatabase`, and make sure the database schema is ready.
    init(_ dbWriter: DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    /// Provides access to the database.
    ///
    /// Application can use a `DatabasePool`, while SwiftUI previews and tests
    /// can use a fast in-memory `DatabaseQueue`.
    ///
    /// See <https://github.com/groue/GRDB.swift/blob/master/README.md#database-connections>
    private let dbWriter: DatabaseWriter
    
    /// The DatabaseMigrator that defines the database schema.
    ///
    /// See <https://github.com/groue/GRDB.swift/blob/master/Documentation/Migrations.md>
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        #if DEBUG
        // Speed up development by nuking the database when migrations change
        // See https://github.com/groue/GRDB.swift/blob/master/Documentation/Migrations.md#the-erasedatabaseonschemachange-option
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        migrator.registerMigration("createKC") { db in
            try db.create(table: "Club") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
                t.column("shortcut", .text)
            }
            try db.create(table: "Member") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
                t.column("firstName", .text)
                t.column("clubId", .integer)  // simple Data Model  (each member can only be member in one Club)
                    .references("club")
                    .indexed()
            }
        }
        
        // Migrations for future application versions will be inserted here:
        // migrator.registerMigration(...) { db in
        //     ...
        // }
        
        return migrator
    }
}

// MARK: - Database Access: Writes Club

extension AppDatabase {
    
    /// Saves (inserts or updates) a club. When the method returns, the
    /// club is present in the database, and its id is not nil.
    func saveClub(_ club: inout Club) throws {
        if club.name.isEmpty {
            print ("Please provide a Club name")
        }
        try dbWriter.write { db in
            try club.save(db)
        }
    }
    
    /// Delete the specified club
    func deleteClub(ids: [Int64]) throws {
        try dbWriter.write { db in
            _ = try Club.deleteAll(db, ids: ids)
        }
    }
    
    /// Delete all clubs
    func deleteAllClubs() throws {
        try dbWriter.write { db in
            _ = try Club.deleteAll(db)
        }
    }
    
//    /// Refresh all users (by performing some random changes, for demo purpose).
//    func refreshClubs() throws {
//
//    }
}

// MARK: - Database Access: Writes Member

extension AppDatabase {
    /// A validation error that prevents some member from being saved into
    /// the database.
//    enum ValidationError: LocalizedError {
//        case missingMemberName
//
//        var errorDescription: String? {
//            switch self {
//            case .missingMemberName:
//                return "Please provide a Member name"
//            }
//        }
//    }
    
    /// Saves (inserts or updates) a club. When the method returns, the
    /// club is present in the database, and its id is not nil.
    func saveMember(_ member: inout Member) throws {
        if member.name.isEmpty {
            print ("Provide a Member Name")
        }
        try dbWriter.write { db in
            try member.save(db)
        }
    }
    
    /// Delete the specified club
    func deleteMember(ids: [Int64]) throws {
        try dbWriter.write { db in
            _ = try Member.deleteAll(db, ids: ids)
        }
    }
    
    /// Delete all clubs
    func deleteAllMember() throws {
        try dbWriter.write { db in
            _ = try Member.deleteAll(db)
        }
    }
    
//    /// Refresh all users (by performing some random changes, for demo purpose).
//    func refreshMember() throws {
//
//    }
}

// MARK: - Database Access: Reads

// This demo app does not provide any specific reading method, and instead
// gives an unrestricted read-only access to the rest of the application.
// In your app, you are free to choose another path, and define focused
// reading methods.
extension AppDatabase {
    /// Provides a read-only access to the database
    var databaseReader: DatabaseReader {
        dbWriter
    }
}
