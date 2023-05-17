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
    
    @EnvironmentObject var kakaoAuthVM: Kakao_AuthVM
    @EnvironmentObject var drinkStore: DrinkStore
    @State var drink: [Drink] = []
    
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
                    
                    NavigationLink(destination: Signin_Complete(drink: self.drink), isActive: $kakaoAuthVM.isLoggedIn,
                                   label:{
                        Button(action: {
                            
                            
                            kakaoAuthVM.handleKakaoLogin()
                            
                            remove_Drink()
//                            set_primary_drink()
                            remove_all_Makgeolli_review()
                                
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
                                set_Makgeolli_Review(name: "장해식", drink_name: "대대포 블루 꿀 막걸리", sweet: 3.0, bitter: Double(i), sour: 3.0, refreshing: 4.0, thick: 2.0, rating: 3.0, comment: "good")
                            }
                            for i in 1...2{
                                set_Makgeolli_Review(name: "장해식", drink_name: "사곡양조 공주 알밤 왕밤주", sweet: Double(i), bitter: 2.0, sour: 3.0, refreshing: 4.0, thick: 2.0, rating: 3.0, comment: "good")
                            }
                            
                            for i in 1...2{
                                set_Spirits_Review(name: "Unknown", drink_name: "한주양조 한주 35도", scent: 2.0, bodied: 3.0, drinkability: 3.0, rating: 3.0, comment: "좋아요")
                            }
                            

                                
                            drinkStore.addNewDrink(drink: drink_s(id: UUID().uuidString, name: "test1", price: 1000, drink_type: "spirits", img_url: ""))
                                
                            print(drinkStore.drinks)
                            print("개")
                            
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
        .navigationViewStyle(.stack)
//        .onAppear{
//            drinkStore.listenToRealtimeDatabase()
//        }
//        .onDisappear{
//            drinkStore.stopListening()
//        }
        
    }

        
}

struct Login_View_Previews: PreviewProvider {
    static var previews: some View {
        Login_View()
            .environmentObject(Kakao_AuthVM())
    }
}
