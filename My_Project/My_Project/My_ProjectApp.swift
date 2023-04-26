//
//  My_ProjectApp.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/14.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon

@main
struct My_ProjectApp: App {
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    
    
    var body: some Scene {
        WindowGroup {
            Login_View()
                .environmentObject(Kakao_AuthVM())
//            Makgeolli_Review_View()
         
        }
    }
}
