//
//  Signin_Complete.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/14.
//

import SwiftUI


enum Tabs{
    case tab1, tab2
}

struct Signin_Complete: View{
    
    @StateObject var kakaoAuthVM: Kakao_AuthVM = Kakao_AuthVM()
    
    @State var tabSelection: Tabs = .tab1
    
    var user_name: String = ""
    var drink: [Drink] = []
    var body: some View{
        
        NavigationView{
            TabView(selection: $tabSelection){

                Drink_List(selected_type: .makgeolli, drinks: self.drink)
                    .tabItem{
                        Image(systemName: "wineglass.fill")
                    }
                Shop()
                    .tabItem{
                        Image(systemName: "cart.fill")
                    }
            }
            .navigationTitle("안녕하세요 " + user_name + "님")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        
        
    }
}


struct Signin_Complete_Previews: PreviewProvider{
    static var previews: some View{
        Signin_Complete()
    }
}
