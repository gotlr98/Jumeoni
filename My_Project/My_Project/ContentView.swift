//
//  ContentView.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/14.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

struct ContentView: View {
    
    @State var user_name: String = ""
    @State private var isActive: Bool = false
    var body: some View {
        
        NavigationView{
            VStack {
                
                GeometryReader{ geo in
                    
                    Text("Korean Traditional Wine \n\n             Community")
                        .frame(alignment: .center)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .position(x: geo.size.width / 2, y: geo.size.height / 5)
                    
                    
                    NavigationLink(
                        destination: Signin_Complete(user_name: $user_name),
                        isActive: $isActive) {
                            
                        // Google Login Button
                            
                        Button(action: {
                            
                            
                            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    
                            // Create Google Sign In configuration object.
                            let config = GIDConfiguration(clientID: clientID)
                            GIDSignIn.sharedInstance.configuration = config
    
                            // Start the sign in flow!
                            GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) {  result, error in
                                guard error == nil else {
                                    // ...
                                    return
                                }
                                
                                guard let user = result?.user,
                                      let idToken = user.idToken?.tokenString
                                else {
                                    // ...
                                    return
                                }
                                
                                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                               accessToken: user.accessToken.tokenString)
                                
                                // ...
                                
                                Auth.auth().signIn(with: credential) { result, error in
                                    
                                    // At this point, our user is signed in
                                }
                                
                                let Cur_user = Auth.auth().currentUser
                                if let Cur_user = Cur_user {
                                    // The user's ID, unique to the Firebase project.
                                    // Do NOT use this value to authenticate with your backend server,
                                    // if you have one. Use getTokenWithCompletion:completion: instead.
                                    let uid = Cur_user.uid
                                    let email = Cur_user.email
                                    let photoURL = Cur_user.photoURL
                                    var multiFactorString = "MultiFactor: "
                                    for info in Cur_user.multiFactor.enrolledFactors {
                                        multiFactorString += info.displayName ?? "[DispayName]"
                                        multiFactorString += " "
                                    }
                                    self.user_name = uid
                                    // ...
                                }
                            }
//                            isActive = true
                        }, label: {
                            Rectangle()
                                .foregroundColor(Color.gray)
                                .frame(width: 130, height: 50)
                                .cornerRadius(15)
                                .overlay{
                                    Text("Google Login")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.black)
                                }
                        })
                    }
                    .position(x: geo.size.width / 2, y: geo.size.height / 1.7)
                    
                    NavigationLink(
                        destination: Signin_Complete(user_name: $user_name),
                        isActive: $isActive) {
                            
                        // Kakao Login Button
                            
                        Button(action: {
                            
                            
                            
                                
                                
                                
                            
//                            isActive = true
                        }, label: {
                            Rectangle()
                                .foregroundColor(Color.gray)
                                .frame(width: 130, height: 50)
                                .cornerRadius(15)
                                .overlay{
                                    Text("Kakao Login")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.black)
                                }
                        })
                    }
                    .position(x: geo.size.width / 2, y: geo.size.height / 1.5)
                    
                        
//                    }, label: {
//                        Rectangle()
//                            .foregroundColor(Color.gray)
//                            .frame(width: 130, height: 50)
//                            .cornerRadius(15)
//                            .overlay{
//                                Text("Google Login")
//                                    .foregroundColor(Color.white)
//                                    .fontWeight(.black)
//                            }
//                    })
//                    .position(x: geo.size.width / 2, y: geo.size.height / 1.7)
                }
            }
            .background(Color.indigo)
        }
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
