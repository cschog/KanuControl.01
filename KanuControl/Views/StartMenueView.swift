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
    @State var showingDetail = false
    
    var body: some View {
        
        ZStack {
            Color(red: 0.20, green: 0.60, blue: 0.86, opacity: 0.70).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text ("KanuControl")
                    .font(.largeTitle)
                Image("logoKanuControl")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140.0, height: 140.0)
                    .padding()
                
                HStack {
                    Spacer()
                    Button("Member") {
                        showingDetail = true
                    }
                    .sheet(isPresented: $showingDetail) {
                        MemberView(isPresented: $showingDetail)
                    }
                    .frame(
                        width: DrawingConstants.frameWidth,
                        height: DrawingConstants.frameHeight)
                    .overlay(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).stroke())
                    .background(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).fill(Color.white))
                    Spacer()
                    
                    Button("Clubs") {
                        showingDetail = true
                    }
                    .sheet(isPresented: $showingDetail) {
                        ClubsView(isPresented: $showingDetail)
                    }
                    .frame(
                        width: DrawingConstants.frameWidth,
                        height: DrawingConstants.frameHeight)
                    .overlay(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).stroke())
                    .background(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).fill(Color.white))
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
}

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
}

//extension View {
//    func hiddenNavigationBarStyle() -> some View {
//        modifier( HiddenNavigationBar() )
//    }
//}

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

