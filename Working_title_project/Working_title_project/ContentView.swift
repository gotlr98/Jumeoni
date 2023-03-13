//
//  ContentView.swift
//  My_Project_App
//
//  Created by HaeSik Jang on 2023/03/05.
//

import SwiftUI
import WebKit
import UIKit
import GoogleSignIn

// 1095324878590-kjepqj4u0nnb4a03p4nsdok1apoq6049.apps.googleusercontent.com

struct MyWebView: UIViewRepresentable {
   
    
    var urlToLoad: String
    
    //ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        
        //unwrapping
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        //웹뷰 인스턴스 생성
        let webView = WKWebView()
        
        //웹뷰를 로드한다
        webView.load(URLRequest(url: url))
        return webView
    }
    
    //업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<MyWebView>) {
        
    }
}

struct ContentView: View {
    var body: some View {
        
        NavigationView{
            VStack {
                
                GeometryReader{ geo in
                    
                    Text("Korean Traditional Wine \n             Community")
                        .frame(alignment: .center)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .position(x: geo.size.width / 2, y: geo.size.height / 5)
                    
//                    Image("AppIcon")
                        
                    
                    NavigationLink(destination:{
                        MyWebView(urlToLoad: "https://www.naver.com")
                        
                    }
                    , label: {
                        VStack{
                            Rectangle()
                                .foregroundColor(Color.gray)
                                .frame(width: 130, height: 50)
                                .cornerRadius(15)
                                .overlay{
                                    Text("Naver Login")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.black)
                                }
                            
                        }
                    })
                    .position(x: geo.size.width / 2, y: geo.size.height / 1.7)
                
//                    NavigationLink(destination:{
//                        MyWebView(urlToLoad: "https://www.google.com")
//
//                    }
//                    , label: {
//                        VStack{
//
//                            Rectangle()
//                                .foregroundColor(Color.gray)
//                                .frame(width: 130, height: 50)
//                                .cornerRadius(15)
//                                .overlay{
//                                    Text("Google Login")
//                                        .foregroundColor(Color.white)
//                                        .fontWeight(.black)
//                                }
//                        }
//                    })
                    
                    Button(action: {
                        let id = "1095324878590-kjepqj4u0nnb4a03p4nsdok1apoq6049.apps.googleusercontent.com" // 여기서는 반전시키지 말고 ID값 그대로 적용한다.
                        let signInConfig = GIDConfiguration(clientID: id)
                        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
                          guard error == nil else { return }
                          guard let user else { return }
                          
                          let email = user.profile?.email
                          let name = user.profile?.name
                          
                          
                          // 1. do를 통해 가져오기
                          user.authentication.do { authentication, error in
                            guard let authentication = authentication else { return }
                            let idToken       = authentication.idToken
                            let accessToken   = authentication.accessToken
                            let refreshToken  = authentication.refreshToken
                            let clientID      = authentication.clientID
                          }
                          
                          // 2. authentication에서 바로 가져오기
                          let idToken       = user.authentication.idToken
                          let accessToken   = user.authentication.accessToken
                          let refreshToken  = user.authentication.refreshToken
                          let clientID      = user.authentication.clientID
                          print(accessToken)
                        }
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
                    .position(x: geo.size.width / 2, y: geo.size.height / 1.5)
                }
                
            }
            .background(Color.indigo)
        }
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        MyWebView(urlToLoad: "https://www.naver.com")
    }
}
