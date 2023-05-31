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


struct Login_View: View {
    
    @EnvironmentObject var kakaoAuthVM: Kakao_AuthVM
    @EnvironmentObject var drinkStore: DrinkStore
    @EnvironmentObject var user_review: UserReviewStore
    
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
                                                        
//                            user_review.getUserFromDatabase()
//                            user_review.getMakgeolliReviewFromDatabase()

//                            self.drink = drinkStore.temp_drink
                            

//                            self.makgeolli_review = user_review.temp_makgeolli_reviews
//                            self.spirits_review = user_review.spirit_reviews
                            
                            
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

                    .position(x: geo.size.width / 2, y: geo.size.height / 1.3)

                }
            }
            .background(Color.indigo)
        }
//        .navigationViewStyle(.stack)
        .onAppear{
            Task{
                drinkStore.setDrink()
                drinkStore.stopListening()
                drinkStore.drinks = []
                
//                user_review.setBaseReview()
//                user_review.setBaseUser()
                
                user_review.getMakgeolliReviewFromDatabase()
                user_review.getSpiritReviewFromDatabase()
//                await user_review.setBaseUser()
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
