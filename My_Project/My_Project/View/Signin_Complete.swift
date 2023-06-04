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
    @EnvironmentObject var user_review: UserReviewStore
    
    @State var isToolBarItemHidden: Bool = true
    @State var tabSelection: Tabs = .tab1
    
    @State var didAppear = false
    @State var appearCount = 0
    
    
    var body: some View{
        
        NavigationView{
            TabView(selection: $tabSelection){

                Drink_List(selected_type: .makgeolli, isToolBarItemHidden: $isToolBarItemHidden)
                    .tabItem{
                        Image(systemName: "wineglass.fill")
                    }
                    .tag(Tabs.tab1)
                    .onAppear {
                        self.isToolBarItemHidden = true
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
        
        .onAppear(perform: onLoad)
        .onDisappear{
            didAppear = false
        }
        .onChange(of: kakao.cur_user, perform: { new in
            user_review.cur_user = new
            user_review.addNewUser(user: new)
        })
        
        .navigationTitle(tabSelection == .tab1 ? "안녕하세요 " + kakao.user_name + "님" : "나의 후기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    
        .navigationViewStyle(.stack)

    }
    
    func onLoad(){
        if !didAppear{
            appearCount += 1
            
            if !drinkStore.isListening{
                drinkStore.listenToRealtimeDatabase()
                drinkStore.isListening = true
//                print(makgeolli_review)
//                user_review.setBaseReview()
            if !user_review.isMakgeolliListening{
                user_review.makgeolliListen()
                user_review.spiritListen()
                user_review.isMakgeolliListening = true
                user_review.isSpiritListening = true
            }
               
            }
        }
        didAppear = true
    }
}


struct Signin_Complete_Previews: PreviewProvider{
    static var previews: some View{
        Signin_Complete()
            .environmentObject(Kakao_AuthVM())
            .environmentObject(DrinkStore())
    }
}
