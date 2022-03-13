import Combine
import Foundation
import GRDB

/// AppDatabase lets the application access the database.
///

struct AppDatabase {
    /// Creates an `AppDatabase`, and make sure the database schema is ready.
    init(_ dbWriter: DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    /// Provides access to the database.
    
    private let dbWriter: DatabaseWriter
    
    /// The DatabaseMigrator that defines the database schema.
    
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
#if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
#endif
        
        migrator.registerMigration("createKC V1.0") { db in
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
    
}

// MARK: - Database Access: Writes & Read Member / MemberInfos

extension AppDatabase {
    
    /// Saves (inserts or updates) a member. When the method returns, the
    /// member is present in the database, and its id is not nil.
    func saveMember(_ member: inout Member) throws {
        try dbWriter.write { db in
            try member.save(db)
        }
    }
    
//    /// Saves (inserts or updates) a membe with the club. When the method returns, the
//    /// member is present in the database, and its id is not nil.
//    func saveMemberInfo(_ memberInfo: inout MemberInfo) throws {
//        try dbWriter.write { db in
//            try memberInfo.save(db)
//        }
//    }
    
    /// Delete the specified member
    func deleteMember(ids: [Int64]) throws {
        try dbWriter.write { db in
            _ = try Member.deleteAll(db, ids: ids)
        }
    }
    
    /// Delete all member
    func deleteAllMember() throws {
        try dbWriter.write { db in
            _ = try Member.deleteAll(db)
        }
    }
    
    /// read all Member including their club
    func readAllMemberWithClub() throws -> [MemberInfo] {
        try dbWriter.read { db in
            let request = Member.including(optional: Member.club)
            return try MemberInfo.fetchAll(db, request)
        }
    }
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
