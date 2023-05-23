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
    
    @EnvironmentObject var kakao: Kakao_AuthVM
    @EnvironmentObject var drinkStore: DrinkStore
    
    @State var isToolBarItemHidden: Bool = true
    @State var tabSelection: Tabs = .tab1
    
    var drink: [drink_s] = []
    
    var body: some View{
        
        NavigationView{
            TabView(selection: $tabSelection){

                Drink_List(selected_type: .makgeolli, isToolBarItemHidden: $isToolBarItemHidden, drinks: self.drink)
                    .tabItem{
                        Image(systemName: "wineglass.fill")
                    }
                    .tag(Tabs.tab1)
                    .onAppear {
                        self.isToolBarItemHidden = true
//                        drink = drinkStore.drinks
                    }
                
//                Shop(url: "", isToolBarItemHidden: $isToolBarItemHidden)
//                    .tabItem{
//                        Image(systemName: "cart.fill")
//                    }
//                    .tag(Tabs.tab2)
//                    .onAppear {
//                        self.isToolBarItemHidden = false
//                    }
                
                User_View()
                    .tabItem{
                        Image(systemName: "person.circle")
                    }
                    .tag(Tabs.tab3)
                    .onAppear{
                        self.isToolBarItemHidden = false
                    }
            }
        }
        
//        .onAppear(perform: {
//            drinkStore.listenToRealtimeDatabase()
//            print(drinkStore.drinks)
//            print(drinkStore.drinks.count)
//        })
//        .onDisappear{
//            drinkStore.stopListening()
//        }
        
        .navigationTitle("안녕하세요 " + kakao.user_name + "님")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    
        .navigationViewStyle(.stack)
        
        

    }
}


struct Signin_Complete_Previews: PreviewProvider{
    static var previews: some View{
        Signin_Complete()
            .environmentObject(Kakao_AuthVM())
            .environmentObject(DrinkStore())
    }
}
