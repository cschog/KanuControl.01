//
//  ContentView.swift
//  KanuControl
//
//  Created by Christoph Schog on 09.02.22.
//

import SwiftUI

struct StartMenueView: View {
    /// Write access to the database
    @Environment(\.appDatabase) private var appDatabase
    
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.20, green: 0.60, blue: 0.86, opacity: 0.70).edgesIgnoringSafeArea(.all)
                NavigationLink(destination: MemberView(), tag: "A", selection: $selection) { EmptyView() }
                NavigationLink(destination: ClubsView(), tag: "B", selection: $selection) { EmptyView() }
                VStack {
                    Image("logoKanuControl")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140.0, height: 140.0)
                        .padding()
                    
                    HStack {
                        Spacer()
                        Button("Member") {
                            selection = "A"
                        }
                        .frame(
                            width: DrawingConstants.frameWidth,
                            height: DrawingConstants.frameHeight)
//                        .background(.white)
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: DrawingConstants.cornerRadius)
                                .stroke())
                        .background(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).fill(Color.white))
                        Spacer()
                        
                        Button("Clubs") {
                            selection = "B"
                        } .frame(
                            width: DrawingConstants.frameWidth,
                            height: DrawingConstants.frameHeight)
                            .overlay(
                                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                                    .stroke())
                            .background(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).fill(Color.white))
                        Spacer()
                    }
                    Spacer()
                }
                .navigationTitle("KanuControl")
            }
        }
        .navigationViewStyle(.stack)
    }
}

private struct DrawingConstants {
    static let cornerRadius: CGFloat = 10
    static let frameWidth: CGFloat = 140
    static let frameHeight: CGFloat = 50
    static let fontScale: CGFloat = 0.7
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartMenueView()
            .previewInterfaceOrientation(.portrait)
    }
}

