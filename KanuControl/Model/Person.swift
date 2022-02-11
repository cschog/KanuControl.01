//
//  Person.swift
//  KanuControl
//
//  Created by Christoph Schog on 11.02.22.
//

import Foundation

struct Person: Identifiable {
    // The person id.

    let id: Int
    let name: String
    let vorname: String
//    let geburtstag: String?
//    let gender: String?
//    let strasse: String?
//    let plz: String?
//    let ort: String?
//    let telefonFestnetz: String?
//    let telefonMobil: String?
//    let email: String?
    var nameGesamt: String {
            return (name + ", " + vorname)
        }
//    let status: Bool    // default aktives Mitglied (= true) oder inaktiv (= false)
//    let statusDatum: String // Datum der Statusänderung, bei der Ersterfassung ist das das Erfassungsdatum
//    let bank: String?
//    let iban: String?
//    let bic: String?
}

