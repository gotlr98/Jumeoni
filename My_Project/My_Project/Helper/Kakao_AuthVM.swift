//
//  Kakao_AuthVM.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/15.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser
import SwiftUI


@MainActor
class Kakao_AuthVM: ObservableObject{
    
    @Published var isLoggedIn : Bool = false
    @Published var user_name: String = ""
    @Published var email: String = ""
    
    @Published var cur_user: user_s = user_s(id: 0, name: "", email: "")
    
    
//    @MainActor
    func kakaoLogout(){
        Task{
            if await handlekakaoLogout() {
                isLoggedIn = false
            }
        }
    }
    
    func handlekakaoLogout() async -> Bool{
        
        await withCheckedContinuation{ continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
}
    
    @MainActor
    func handleLoginWithKakaoTalkApp() async -> Bool {
        
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
    
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    continuation.resume(returning: true)

                    //do something
                    _ = oauthToken
                    
                    //사용자 정보 불러옴
                    UserApi.shared.me { [self] user, error in
                       if let error = error {
                           print(error)
                       } else {
                           
                           guard let token = oauthToken?.accessToken, let email = user?.kakaoAccount?.email,
                                 let name = user?.kakaoAccount?.profile?.nickname,
                                 let id = user?.id else{
                                     print("token/email/name is nil")
                                     return
                                 }

                           self.user_name = name
//                           self.user.name = name
                           self.email = email.replacingOccurrences(of: ".", with: ",")
                           
                           self.cur_user = user_s(id: id, name: name, email: self.email)
//                           userStore.addNewUser(user: user_s(id: UUID().uuidString, name: name, email: self.email))
                           
                       }
                   }
                    
                }
            }
        }
        
    }
    
    @MainActor
    func handleLoginWithKakaoAccount() async -> Bool {
        
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                        continuation.resume(returning: false)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")
                        continuation.resume(returning: true)
                        //do something
                        _ = oauthToken
                        
                        UserApi.shared.me { [self] user, error in
                           if let error = error {
                               print(error)
                           } else {
                               
                               guard let token = oauthToken?.accessToken, let email = user?.kakaoAccount?.email,
                                     let name = user?.kakaoAccount?.profile?.nickname,
                                     let id = user?.id else{
                                         print("token/email/name is nil")
                                         return
                                     }

                               self.user_name = name
                               self.email = email.replacingOccurrences(of: ".", with: ",")
                               
                               self.cur_user = user_s(id: id, name: name, email: self.email)


                           }
                       }
                    }
                }
            
        }
        
        
        
    }
    
//    @MainActor
    func handleKakaoLogin(){
        
        Task{
            // 카카오톡 실행 가능 여부 확인 - 설치 되어있을 때
            if (UserApi.isKakaoTalkLoginAvailable()) {
                                
                // 카카오 앱을 통해 로그인
                isLoggedIn = await handleLoginWithKakaoTalkApp()
                
                
                
            }
            else { // 설치 안되어 있을 때
                isLoggedIn = await handleLoginWithKakaoAccount()
            }
            

        }

    }
    
//    func add_user_makgeolli_review(review: Makgeolli_Review){
//
//        user.makgeolli_reviews.append(review)
//
//        self.objectWillChange.send()
//    }
//
//    func add_user_spirits_review(review: Spirits_Review){
//
//        user.spirits_reviews.append(review)
//
//        self.objectWillChange.send()
//    }

}
