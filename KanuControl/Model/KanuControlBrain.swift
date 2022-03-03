//
//  KanuControlBrain.swift
//  KanuControl
//
//  Created by Christoph Schog on 11.02.22.
//

import Foundation

class KanuControlBrain: ObservableObject {
    
    @Published var personen = [
        Member(id: 0, name: "Schog", vorname: "Chris"),
        Member(id: 1, name: "Schog", vorname: "Hildegard"),
        Member(id: 2, name: "Schog", vorname: "Lotta")
    ]
    
    @Published var vereine = [
        Club(id: 0, name: "Eschweiler Kanu Club", shortcut: "EKC"),
        Club(id: 1, name: "Kanu Club Delphin", shortcut: "KCD"),
        Club(id: 2, name: "Kanu Club Zugvogel", shortcut: "KCZ")
    ]

    
}
