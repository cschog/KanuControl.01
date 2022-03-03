//
//  VereineDetailView.swift
//  KanuControl
//
//  Created by Christoph Schog on 24.02.22.
//

import SwiftUI

/// The view that edits an existing player.
struct ClubsEditionView: View {
    /// Write access to the database
    @Environment(\.appDatabase) private var appDatabase
    @Environment(\.isPresented) private var isPresented
    private let club: Club
    @State private var form: ClubForm
    
    init(club: Club) {
        self.club = club
        self.form = ClubForm(club)
    }
    
    var body: some View {
        ClubFormView(form: $form)
            .onChange(of: isPresented) { isPresented in
                // Save when back button is pressed
                if !isPresented {
                    var savedClub = club
                    form.apply(to: &savedClub)
                    // Ignore error because I don't know how to cancel the
                    // back button and present the error
                    try? appDatabase.saveClub(&savedClub)
                }
            }
    }
}

//struct ClubsEditionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClubsEditionView(club: club)
//    }
//}
