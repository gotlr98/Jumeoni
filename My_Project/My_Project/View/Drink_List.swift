//
//  Drink_Info.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/30.
//

import SwiftUI
import Foundation
import Kingfisher

struct Drink_List: View {
    
    @EnvironmentObject var drinkStore: DrinkStore
    @EnvironmentObject var user_review: UserReviewStore
    @EnvironmentObject var kakao: Kakao_AuthVM
    
    @State var selected_type: drink.drink_type = .makgeolli
    @State var show_sheet: Bool = false
    @State var cliked_button: Bool = false
    @Binding var isToolBarItemHidden: Bool
    @State private var dismissed: Bool = false

    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var drinks: [drink] = []
    @State var selected_drink = drink(id: UUID().uuidString, name: "", price: 0, drink_type: "", img_url: "")
    
    var body: some View {
        let filter_drink = drinks.filter{ (element) -> Bool in
            if selected_type == .makgeolli{
                return element.drink_type == "makgeolli"
            }
            else if selected_type == .spirits{
                return element.drink_type == "spirits"
            }

            return false
        }
        
        GeometryReader{ geo in
            ScrollView{
                ZStack {
                    NavigationLink(destination: Review_View(drink: selected_drink, selected_type: $selected_type), isActive: $cliked_button, label: {
                        EmptyView()
                    })
                    .onAppear{
                        self.drinks = drinkStore.temp_drink
                    }
                }
                .opacity(0.0)
                .buttonStyle(PlainButtonStyle())
                
                LazyVGrid(columns: columns, alignment: .center, spacing: 10, content:{
                    ForEach(filter_drink, id: \.id) { drink in
                        
                        // Button 클릭되면 NavigationLink 동작
                        Button(action: {
                            selected_drink = drink
                            self.cliked_button = true
                            
                        }, label: {
                            ZStack(alignment: .center){
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(Color.white)
                                    .shadow(color: Color.black.opacity(0.5), radius: 1, x: -0.2, y: 1)
                                
                                VStack{
                                    KFImage(URL(string: drink.img_url))
                                        .placeholder{
                                            Color.gray
                                        }
                                        .onFailure{ e in
                                            print("failure \(e)")
                                        }
                                        .resizable()
                                        .frame(width: 90, height: 90)
                                        .onAppear()
                                    
                                    Text(drink.name)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 15))
                                }
                            }
                            .frame(width: (UIScreen.main.bounds.width / 2) - 80,
                                height: ((UIScreen.main.bounds.width / 2) - 80) * 1.5,
                                alignment: .center)
                        })
                    }
                    .padding()
                })
                .padding()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.white]), startPoint: .center, endPoint: .bottomTrailing).opacity(0.3))
            .refreshable {
                self.drinks = drinkStore.drinks
            }
        }
        .toolbar{
            if isToolBarItemHidden{
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Menu("Menu"){
                        Button(action: {
                            self.selected_type = .makgeolli
                        }, label: {
                            Text("막걸리")
                                .foregroundColor(.black)
                        })
                        
                        Button(action: {
                            self.selected_type = .spirits
                        }, label: {
                            Text("증류주")
                                .foregroundColor(.black)
                        })
                    }
                })
                ToolbarItem(placement: .navigationBarTrailing, content:{
                    
                    Button(action: {
                        self.show_sheet.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 20))
                            .foregroundColor(Color.gray)
                    })
                })
            }
        }
        .fullScreenCover(isPresented: $show_sheet){
            Button(role: .cancel, action: {
                show_sheet = false
            }, label: {
                Text("닫기")
            })
            Register_Drink(selected_type: selected_type, drinks: $drinks, show_sheet: $show_sheet)
        }
    }
}
