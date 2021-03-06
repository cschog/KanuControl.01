//
//  DataBaseManager.swift
//  KanuControl
//
//  Created by Christoph Schog on 22.02.22.
//

import Foundation
import SwiftUI
import GRDB

var dbQueue: DatabaseQueue!

class DatabaseManager {
    
    static func setup(for application: UIApplication) throws {
        let databaseURL = try FileManager.default
            .url(for: .applicationDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("KanuControl.sqlite")
        
        dbQueue = try DatabaseQueue(path: databaseURL.path)
        //dbQueue.setupMemoryManagement(in: application)
        
        try migrator.migrate(dbQueue)
        
        print ("Datenbank-URL:", databaseURL)
    }
    
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
#if DEBUG
        // Speed up development by nuking the database when migrations change
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
                t.column("clubId", .integer)  // einfaches Datenmodell (jede Person kann nur in einem Verein Mitglied sein
                    .references("club")
                    .indexed()
            }
        }
        
        return migrator
    }
    
}
