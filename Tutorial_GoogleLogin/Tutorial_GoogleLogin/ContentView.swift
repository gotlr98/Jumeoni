//
//  ContentView.swift
//  Tutorial_GoogleLogin
//
//  Created by HaeSik Jang on 2023/03/13.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


func handleSignInButton() {
  GIDSignIn.sharedInstance.signIn(
    withPresenting: FirstViewController()) { signInResult, error in
      guard let result = signInResult else {
        // Inspect error
        return
      }
      // If sign in succeeded, display the app's main content View.
    }
  
}
struct ContentView: View {
    var body: some View {
        VStack {
            GoogleSignInButton(action: handleSignInButton)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
