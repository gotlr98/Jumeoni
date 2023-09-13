//
//  Kakao_Login++Bundle.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/16.
//

import Foundation

import Foundation

extension Bundle{
    var apiKey: String{
        guard let file = self.path(forResource: "MyApi", ofType: "plist") else {return ""}
        
        guard let resource = NSDictionary(contentsOfFile: file) else {return ""}
        guard let key = resource["API_KEY"] as? String else{ fatalError("MyApi - API_KEY Set Please")}
        print(key)
        return key
                
    }
}
