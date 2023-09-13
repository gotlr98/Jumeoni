//
//  ContentView.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/14.
//

import SwiftUI
import Foundation
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import AuthenticationServices


struct Login_View: View {
    
    @EnvironmentObject var kakaoAuthVM: Kakao_AuthVM
    @EnvironmentObject var drinkStore: DrinkStore
    @EnvironmentObject var user_review: UserReviewStore
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    
    @State var user: [user_s] = []
    @State var makgeolli_review: [makgeolli_review] = []
    @State var spirits_review: [spirit_review] = []

    
    var body: some View {
        
        NavigationView{
            
            ZStack {
                GeometryReader{ geo in
                    
                    Text("주(酒)머니")
                        .frame(alignment: .center)
                        .tracking(7)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 60))
                        .position(x: geo.size.width / 2, y: geo.size.height / 4)

                    // Kakao Login Button
                    
                    NavigationLink(destination: Signin_Complete(), isActive: $kakaoAuthVM.isLoggedIn,
                                   label:{
                        Button(action: {
                            kakaoAuthVM.handleKakaoLogin()
                        }, label: {
                            Rectangle()
                                .foregroundColor(Color.gray)
                                .frame(width: 170, height: 68)
                                .cornerRadius(15)
                                .overlay{
                                    Text("Kakao Login")
                                        .font(.system(size: 23))
                                        .foregroundColor(Color.white)
                                        .fontWeight(.black)
                                }
                        })
                    })

                    .position(x: geo.size.width / 2, y: geo.size.height / 1.5)
                    
                    
                    SignInWithAppleButton(.continue) { request in
                        
                        request.requestedScopes = [.email, .fullName]
                        
                    } onCompletion: { result in
                        
                        switch result{
                        case .success(let auth):
                            switch auth.credential{
                            case let credential as ASAuthorizationAppleIDCredential:
                                let userId = credential.user
                                if let email = credential.email{}
                                if let firstName = credential.fullName?.givenName{}
                                if let lastName = credential.fullName?.familyName{}
                                self.userId = userId
                                self.email = email
                                self.firstName = firstName
                                self.lastName = lastName
                                
                                let fullName = firstName + lastName
                                
                                kakaoAuthVM.user_name = fullName
                                kakaoAuthVM.email = email.replacingOccurrences(of: ".", with: ",")
                                
                                kakaoAuthVM.cur_user = user_s(id: String(userId), name: kakaoAuthVM.user_name, email: kakaoAuthVM.email)
                                
                                kakaoAuthVM.isLoggedIn = true
                                
                            default:
                                break
                            }
                            
                        case .failure(let error):
                            print(error)
                        }
                        
                    }
                    .signInWithAppleButtonStyle(
                        colorScheme == .dark ? .white : .black
                    )
                    .frame(height: 50)
                    .cornerRadius(8)
                    .position(x: geo.size.width / 2, y: geo.size.height / 1.3)
//                    .background(Color.white)
                        

                }
            }
            .background(Color.indigo)
        }
        .onAppear{
            Task{
                drinkStore.setDrink()
                drinkStore.stopListening()
                drinkStore.drinks = []
                
                
                user_review.getMakgeolliReviewFromDatabase()
                user_review.getSpiritReviewFromDatabase()
                user_review.stopListening()
                user_review.makgeolli_reviews = []
                user_review.spirit_reviews = []
            }
            
        }

        
    }
    
    

        
}


//struct AppleSigninButton : View{
//    var body: some View{
//        SignInWithAppleButton(
//            onRequest: { request in
//                request.requestedScopes = [.fullName, .email]
//            },
//            onCompletion: { result in
//                switch result {
//                case .success(let authResults):
//                    print("Apple Login Successful")
//                    switch authResults.credential{
//                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
//                           // 계정 정보 가져오기
//                            let UserIdentifier = appleIDCredential.user
//                            let fullName = appleIDCredential.fullName
//                            let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
//                            let email = appleIDCredential.email
//                            let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
//                            let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
//                    default:
//                        break
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    print("error")
//                }
//            }
//        )
//        .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
//        .cornerRadius(5)
//    }
//}

struct Login_View_Previews: PreviewProvider {
    static var previews: some View {
        Login_View()
            .environmentObject(Kakao_AuthVM())
    }
}
