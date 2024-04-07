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
                                .frame(width: 300, height: 50)
                                .cornerRadius(15)
                                .overlay{
                                    Text("Kakao Login")
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
                                
                                // firebase '.'오류로 인한 ',' 변경
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
                    .frame(width: 300, height: 50)
                    .cornerRadius(8)
                    .position(x: geo.size.width / 2, y: geo.size.height / 1.3)
                    
                    // 소셜 로그인이 포함된 경우 Guest Login이 필수로 포함되어야함
                    Button(action: {
                        kakaoAuthVM.isLoggedIn = true
                        kakaoAuthVM.user_name = "Guest"
                    }, label: {
                        Rectangle()
                            .foregroundColor(Color.gray)
                            .frame(width: 300, height: 50)
                            .cornerRadius(15)
                            .overlay{
                                Text("Guest Login")
                                    .foregroundColor(Color.white)
                                    .fontWeight(.black)
                            }
                    })
                    .position(x: geo.size.width / 2, y: geo.size.height / 1.1)
                }
            }
            .background(Color.indigo)
        }
        .onAppear{
            
            // Firebase RealTime Database 설정
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

struct Login_View_Previews: PreviewProvider {
    static var previews: some View {
        Login_View()
            .environmentObject(Kakao_AuthVM())
    }
}
