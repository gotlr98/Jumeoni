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


    var body: some View{
        
        VStack{
            
            TabView{

                Drink_Info()
                    .tabItem{
                        Image(systemName: "wineglass.fill")
                    }
                Shop()
                    .tabItem{
                        Image(systemName: "cart.fill")
                    }
            }
            
        }
        .navigationTitle("Hello " + user_name + "님")
    }
        

}


struct Signin_Complete_Previews: PreviewProvider{
    static var previews: some View{
        Signin_Complete()
    }
}
