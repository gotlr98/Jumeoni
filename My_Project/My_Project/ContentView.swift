//
//  ContentView.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/14.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

struct ContentView: View {
    
    @StateObject var kakaoAuthVM: Kakao_AuthVM = Kakao_AuthVM()
    @Binding var isLoggedIn: Bool
    @Binding var name: String
    
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
                    
       
                    // Kakao Login Button
                    
                    NavigationLink(destination: Signin_Complete(test: kakaoAuthVM.user_name), isActive: $kakaoAuthVM.isLoggedIn,
                                   label:{
                        Button(action: {
                            
                            kakaoAuthVM.handleKakaoLogin()
                            
                            
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

                    .position(x: geo.size.width / 2, y: geo.size.height / 1.5)
                    
                        
                }
            }
            .background(Color.indigo)
        }
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isLoggedIn: .constant(false), name: .constant(""))
    }
}
