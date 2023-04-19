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
import RealmSwift


struct Login_View: View {
    
    @StateObject var kakaoAuthVM: Kakao_AuthVM = Kakao_AuthVM()
    @Binding var isLoggedIn: Bool
    @Binding var name: String
    @State var drink: [Drink] = []
    
    
    var body: some View {
        
        NavigationView{
            
            ZStack {
                GeometryReader{ geo in
                    
//                    Image("house")
//                        .edgesIgnoringSafeArea(.all)
                    
                    Text("酒머니")
                        .frame(alignment: .center)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 60))
                        .position(x: geo.size.width / 2, y: geo.size.height / 4)

                    // Kakao Login Button
                    
                    NavigationLink(destination: Signin_Complete(user_name: kakaoAuthVM.user_name, drink: self.drink), isActive: $kakaoAuthVM.isLoggedIn,
                                   label:{
                        Button(action: {
                            
                            kakaoAuthVM.handleKakaoLogin()
                            
//                            remove_Drink()
//                            set_primary_drink()
                            remove_all_review()
                                
                            if get_All_Drink().count == 0{
                                set_primary_drink()
                            }
                            
                            for i in get_All_Drink(){
                                
                                if i.drink_type == "makgeolli"{
                                    self.drink.append(
                                    Drink(id: UUID(), name: i.name, type: .makgeolli, price: i.price, img_url: i.img_url)
                                    )
                                }
                                
                                else if i.drink_type == "spirits"{
                                    self.drink.append(
                                    Drink(id: UUID(), name: i.name, type: .spirits, price: i.price, img_url: i.img_url)
                                    )
                                }
                                
                            }
                            
                            for i in 1...2{
                                set_Review(name: "sik", drink_name: "대대포 블루 꿀 막걸리", rating: Int8(i), comment: "Not bad", drink_type: "makgeolli")
                            }
                            for i in 1...2{
                                set_Review(name: "hae", drink_name: "사곡양조 공주 알밤 왕밤주", rating: Int8(i), comment: "good", drink_type: "makgeolli")
                            }
                            print("## realm file dir -> \(Realm.Configuration   .defaultConfiguration.fileURL!)")
                            
                            
                        }, label: {
                            Rectangle()
                                .foregroundColor(Color.gray)
                                .frame(width: 180, height: 70)
                                .cornerRadius(15)
                                .overlay{
                                    Text("Kakao Login")
                                        .font(.system(size: 25))
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
        .navigationViewStyle(StackNavigationViewStyle())
        
    }

        
}

struct Login_View_Previews: PreviewProvider {
    static var previews: some View {
        Login_View(isLoggedIn: .constant(false), name: .constant(""))
    }
}
