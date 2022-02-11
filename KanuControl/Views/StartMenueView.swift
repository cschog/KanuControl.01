//
//  ContentView.swift
//  KanuControl
//
//  Created by Christoph Schog on 09.02.22.
//

import SwiftUI


struct StartMenueView: View {
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    NavigationLink(destination: MitgliederView(), tag: "Mitglieder", selection: $selection) { EmptyView() }
                    NavigationLink(destination: VereineView(), tag: "Vereine", selection: $selection) { EmptyView() }
                    
                    Image("logoKanuControl")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140.0, height: 140.0)
                        .padding()
                    
                    HStack {
                        Spacer()
                        Button("Mitglieder") {
                            selection = "Mitglieder"
                        } .frame(width: 140.0, height: 50.0)
                            .background(.white)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        Spacer()
                        
                        Button("Vereine") {
                            selection = "Vereine"
                        } .frame(width: 140.0, height: 50.0)
                            .background(.white)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    Spacer()
                }
                .navigationTitle("KanuControl")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartMenueView()
            .previewInterfaceOrientation(.portrait)
    }
}

