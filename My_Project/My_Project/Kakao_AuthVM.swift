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


class Kakao_AuthVM: ObservableObject{
    
    @Published var isLoggedIn : Bool = false
    @Published var user_name: String = ""
    
    
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
                                 let name = user?.kakaoAccount?.profile?.nickname else{
                                     print("token/email/name is nil")
                                     return
                                 }

                           self.user_name = name
                         
                       }
                   }
                    

                }
            }
        }
        
    }
    
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
                                     let name = user?.kakaoAccount?.profile?.nickname else{
                                         print("token/email/name is nil")
                                         return
                                     }

                               self.user_name = name
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

}
