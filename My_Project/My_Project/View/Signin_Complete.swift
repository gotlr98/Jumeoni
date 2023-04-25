//
//  Signin_Complete.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/14.
//

import SwiftUI


enum Tabs{
    case tab1, tab2, tab3
}

struct Signin_Complete: View{
    
    @StateObject var kakaoAuthVM: Kakao_AuthVM = Kakao_AuthVM()
    
    @State var isToolBarItemHidden: Bool = true
    @State var tabSelection: Tabs = .tab1
    
    var user_name: String = ""
    var drink: [Drink] = []
    var user: User_Info = User_Info()
    
    var body: some View{
        
        NavigationView{
            TabView(selection: $tabSelection){

                Drink_List(selected_type: .makgeolli, isToolBarItemHidden: $isToolBarItemHidden, name: user_name,user: user, drinks: self.drink)
                    .tabItem{
                        Image(systemName: "wineglass.fill")
                    }
                    .tag(Tabs.tab1)
                    .onAppear {
                        self.isToolBarItemHidden = true
                    }
                
                Shop(isToolBarItemHidden: $isToolBarItemHidden)
                    .tabItem{
                        Image(systemName: "cart.fill")
                    }
                    .tag(Tabs.tab2)
                    .onAppear {
                        self.isToolBarItemHidden = false
                    }
                
                User_View(user: self.user)
                    .tabItem{
                        Image(systemName: "person.circle")
                    }
                    .tag(Tabs.tab3)
                    .onAppear{
                        self.isToolBarItemHidden = false
                    }
            }
            
        }
        .navigationTitle("안녕하세요 " + user_name + "님")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    
        .navigationViewStyle(.stack)
        
    }
}


struct Signin_Complete_Previews: PreviewProvider{
    static var previews: some View{
        Signin_Complete()
    }
}
