//
//  Signin_Complete.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/14.
//

import SwiftUI



struct Signin_Complete: View{
    
    @Binding var user_name: String
    
//    ContentView
    var body: some View{
        Text("Hello" + user_name)
        
    }
}


struct Signin_Complete_Previews: PreviewProvider{
    static var previews: some View{
        Signin_Complete(user_name: Binding.constant("empty"))
    }
}
