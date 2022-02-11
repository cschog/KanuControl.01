//
//  KanuControlBrain.swift
//  KanuControl
//
//  Created by Christoph Schog on 11.02.22.
//

import Foundation

class KanuControlBrain: ObservableObject {
    
    @Published var personen = [
        Person(id: 0, name: "Schog", vorname: "Chris"),
        Person(id: 1, name: "Schog", vorname: "Hildegard"),
        Person(id: 2, name: "Schog", vorname: "Lotta")
    ]

    
}
