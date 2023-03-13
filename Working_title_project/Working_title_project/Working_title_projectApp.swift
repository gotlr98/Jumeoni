//
//  Working_title_projectApp.swift
//  Working_title_project
//
//  Created by HaeSik Jang on 2023/03/13.
//

import SwiftUI
import GoogleSignIn
//import Firebase

//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if FirebaseApp.app() == nil {
                FirebaseApp.configure()
    }
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
}

func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {

// 이 부분이 핵심
        if GIDSignIn.sharedInstance().handle(url) {
        return true
    }
    return false
}

@main
struct Working_title_projectApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
