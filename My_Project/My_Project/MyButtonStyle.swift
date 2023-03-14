//
//  MyButtonStyle.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/14.
//

import Foundation
import SwiftUI

struct MyButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View{
        configuration.label
            .foregroundColor(Color.gray)
            .frame(width: 130, height: 50)
            .cornerRadius(15)
            .overlay{
                Text("Google Login")
                    .foregroundColor(Color.white)
                    .fontWeight(.black)
            }
        
    }
}
