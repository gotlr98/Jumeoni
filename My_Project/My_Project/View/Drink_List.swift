//
//  Drink_Info.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/30.
//

import SwiftUI
import Foundation
import Kingfisher
import RealmSwift

struct Drink_List: View {
    
    @EnvironmentObject var drinkStore: DrinkStore
    
    @State var selected_type: drink_s.drink_type = .makgeolli
    @State var show_sheet: Bool = false
    @State var cliked_button: Bool = false
    @Binding var isToolBarItemHidden: Bool
    @State private var dismissed: Bool = false

    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
//    @State var drinks = Signin_Complete().drink
    @State var drinks: [drink_s] = []

    
//    @State var spirits_review: Results<Spirits_Review> = get_All_Spirits_Review()
//    @State var makgeolli_review: Results<Makgeolli_Review> = get_All_Makgeolli_Review()
    @State var selected_drink = drink_s(id: UUID().uuidString, name: "", price: 0, drink_type: "", img_url: "")

    
    var body: some View {
        
//        let filter_drink = drinkStore.drinks.filter{$0.drink_type == selected_type}
        let filter_drink = drinkStore.drinks
        
        GeometryReader{ geo in
            ScrollView{
                ZStack {
//                    NavigationLink(destination: Review_View(drink: selected_drink, makgeolli_review: $makgeolli_review, spirits_review: $spirits_review, selected_type: $selected_type), isActive: $cliked_button, label: {
//                        EmptyView()
//                    })
                    NavigationLink(destination: Review_View(drink: selected_drink, selected_type: $selected_type), isActive: $cliked_button, label: {
                        EmptyView()
                    })
                }
//                .onAppear(perform: onLoad)
//                .onDisappear{
//                    drinkStore.stopListening()
//                    didAppear = false
//                }
                .opacity(0.0)
                .buttonStyle(PlainButtonStyle())
                
                LazyVGrid(columns: columns, alignment: .center, spacing: 10, content:{
                
                    ForEach(filter_drink, id: \.id) { drink in
                        Button(action: {
                            selected_drink = drink
                            self.cliked_button = true
                            
                        }, label: {
                            VStack{
                                KFImage(URL(string: drink.img_url))
                                    .placeholder{
                                        Color.gray
                                    }
                                    .onFailure{ e in
                                        print("failure \(e)")
                                    }
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .onAppear()

                                Text(drink.name)
                                .foregroundColor(Color.black)
                                .font(.system(size: 15))
                            }

                        })
                        
                        }
                        .padding()
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.blue, lineWidth: 4)
                            )

                })

                .padding()

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
        
            Register_Drink(drink: $drinks, show_sheet: $show_sheet)
        }
        
//        .navigationViewStyle(.stack)
    }
    

}



//struct Drink_Info_Previews: PreviewProvider {
//    static var previews: some View {
//        Drink_List(selected_type: .makgeolli)
//    }
//}
