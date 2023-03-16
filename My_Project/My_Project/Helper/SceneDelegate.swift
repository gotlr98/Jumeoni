//
//  SceneDelegate.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/15.
//

import Foundation
import UIKit
import KakaoSDKAuth


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}
