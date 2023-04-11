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

func makeBlur(target: Image){
    let blur = UIBlurEffect(style: .regular)
    let visualBlurEffect = UIVisualEffectView(effect: blur)
    visualBlurEffect.alpha = 0
//    visualBlurEffect.frame = imageView
}

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
                    
                    Text("술다방 / 酒머니 / 술맛좋다")
                        .frame(alignment: .center)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 40))
                        .position(x: geo.size.width / 2, y: geo.size.height / 5)

                    // Kakao Login Button
                    
                    NavigationLink(destination: Signin_Complete(user_name: kakaoAuthVM.user_name, drink: self.drink), isActive: $kakaoAuthVM.isLoggedIn,
                                   label:{
                        Button(action: {
                            
                            kakaoAuthVM.handleKakaoLogin()
                            
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
                            print("## realm file dir -> \(Realm.Configuration.defaultConfiguration.fileURL!)")
                            
                            
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
                    })

                    .position(x: geo.size.width / 2, y: geo.size.height / 1.3)
                    
                    

                }
            }
            .background(Color.indigo)
        }
        
    }
        
}

struct Login_View_Previews: PreviewProvider {
    static var previews: some View {
        Login_View(isLoggedIn: .constant(false), name: .constant(""))
    }
}
