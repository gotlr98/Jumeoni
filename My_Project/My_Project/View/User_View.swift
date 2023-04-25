//
//  User_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/25.
//

import SwiftUI

struct User_View: View {
    
    var user: User_Info = User_Info()
    
    var body: some View {
        Button(action: {
            print(user.name)
            print(user.makgeolli_reviews)
            print("nil")
        }, label: {
            Text("check")
        })
    }
}

struct User_View_Previews: PreviewProvider {
    static var previews: some View {
        User_View()
    }
}
