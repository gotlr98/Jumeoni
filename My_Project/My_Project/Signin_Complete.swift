//
//  Signin_Complete.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/14.
//

import SwiftUI



struct Signin_Complete: View{
    
    @StateObject var kakaoAuthVM: Kakao_AuthVM = Kakao_AuthVM()
    
    var user_name: String = ""

//    ContentView
    var body: some View{
        
        VStack{
            
            Text(user_name)
            
        }
    }

}


struct Signin_Complete_Previews: PreviewProvider{
    static var previews: some View{
        Signin_Complete()
    }
}
