//
//  Person.swift
//  KanuControl
//
//  Created by Christoph Schog on 11.02.22.
//

import Foundation
import GRDB

struct Person: Identifiable {
    // The person id.

    var id: Int64?
    var name: String
    var vorname: String?
    var vereinID: Int64?
}

extension Person: Codable, FetchableRecord, MutablePersistableRecord { }
