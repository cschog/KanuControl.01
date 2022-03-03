//
//  KanuControlApp.swift
//  KanuControl
//
//  Created by Christoph Schog on 09.02.22.
//


import SwiftUI
//import UIKit
import GRDBQuery

//// https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-an-appdelegate-to-a-swiftui-app
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//        try! DatabaseManager.setup(for: application)
//
//        return true
//    }
//}


@main
struct KanuControlApp: App {
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            StartMenueView().environment(\.appDatabase, .shared)
        }
    }
}

// MARK: - Give SwiftUI access to the database
//
// Define a new environment key that grants access to an AppDatabase.
//
// The technique is documented at
// <https://developer.apple.com/documentation/swiftui/environmentkey>.

private struct AppDatabaseKey: EnvironmentKey {
    static var defaultValue: AppDatabase { .empty() }
}

extension EnvironmentValues {
    var appDatabase: AppDatabase {
        get { self[AppDatabaseKey.self] }
        set { self[AppDatabaseKey.self] = newValue }
    }
}

// In this demo app, views observe the database with the @Query property
// wrapper, defined in the GRDBQuery package. Its documentation recommends to
// define a dedicated initializer for `appDatabase` access, so we comply:

extension Query where Request.DatabaseContext == AppDatabase {
    /// Convenience initializer for requests that feed from `AppDatabase`.
    init(_ request: Request) {
        self.init(request, in: \.appDatabase)
    }
}
