//
//  AppDelegate.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/14.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import RealmSwift
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        let kakaoAppKey = Bundle.main.apiKey
        // Kakao SDK 초기화
        
        KakaoSDK.initSDK(appKey: kakaoAppKey)
        
        let config = Realm.Configuration(
                          schemaVersion: 4,
                          migrationBlock: { migration, oldSchemaVersion in
                              if oldSchemaVersion < 5 {
                                  migration.enumerateObjects(ofType: User_Info.className()) { oldObject, newObject in
                                      newObject!["drink_name"] = Review() // 내가 수정한 부분
                                  }
                              }
                          }
                      )
                      Realm.Configuration.defaultConfiguration = config
        
        FirebaseApp.configure()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                return AuthController.handleOpenUrl(url: url)
            }

            return false
        }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        
        sceneConfiguration.delegateClass = SceneDelegate.self
        
        return sceneConfiguration
    }
    

    
}


