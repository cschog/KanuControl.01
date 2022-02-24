//
//  KanuControlApp.swift
//  KanuControl
//
//  Created by Christoph Schog on 09.02.22.
//


import SwiftUI
import UIKit

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-an-appdelegate-to-a-swiftui-app

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        try! DatabaseManager.setup(for: application)
        
        return true
    }
}


@main
struct KanuControlApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            StartMenueView()
        }
    }
}
