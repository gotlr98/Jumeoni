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
                Group{
                    Drink_List(selected_type: .makgeolli, isToolBarItemHidden: $isToolBarItemHidden)
                        .tabItem{
                            Label("술리뷰", systemImage: "wineglass.fill")
                        }
                        .tag(Tabs.tab1)
                        .onAppear {
                            self.isToolBarItemHidden = true
                        }
                    
                    User_View()
                        .tabItem{
                            Label("마이페이지", systemImage: "person.circle")
                        }
                        .tag(Tabs.tab2)
                        .onAppear{
                            self.isToolBarItemHidden = false
                        }
                }
                .toolbarBackground(Color.teal, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
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
        UITabBar.appearance().barTintColor = .blue
        
        // Firebase Realtime Database Load안된경우 다시한번 읽어오기 & 중복 방지
        if !didAppear{
            appearCount += 1
            if !drinkStore.isListening{
                drinkStore.listenToRealtimeDatabase()
                drinkStore.isListening = true
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
