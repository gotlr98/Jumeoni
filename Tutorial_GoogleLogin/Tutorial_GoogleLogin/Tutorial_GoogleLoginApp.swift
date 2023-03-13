//
//  Tutorial_GoogleLoginApp.swift
//  Tutorial_GoogleLogin
//
//  Created by HaeSik Jang on 2023/03/13.
//

import SwiftUI
import GoogleSignIn


//func application(
//  _ app: UIApplication,
//  open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
//) -> Bool {
//  var handled: Bool
//
//  handled = GIDSignIn.sharedInstance.handle(url)
//  if handled {
//    return true
//  }
//
//  // Handle other custom URL types.
//
//  // If not handled by this app, return false.
//  return false
//}

@main
struct Tutorial_GoogleLoginApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                          GIDSignIn.sharedInstance.handle(url)
            }
                .onAppear {
                          GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                            // Check if `user` exists; otherwise, do something with `error`
                          }
                        }
        }
    }
}
