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
    
    @State var selected_type: Drink.drink_type = .makgeolli
    @State var show_sheet: Bool = false
    @State var cliked_button: Bool = false
    @State private var dismissed: Bool = false
    
//    @State private var drinks = [
//        Drink(id: UUID(), name: "cham", type: Drink.drink_type.makgeolli, price: 1950, img_url: "1"),
//        Drink(id: UUID(), name: "cass", type: Drink.drink_type.makgeolli, price: 1500, img_url: "1"),
//        Drink(id: UUID(), name: "terra", type: Drink.drink_type.makgeolli, price: 1500, img_url: "1"),
//        Drink(id: UUID(), name: "cheoeum", type: Drink.drink_type.makgeolli, price: 1950, img_url: "1"),
//        Drink(id: UUID(), name: "jangsoo", type: Drink.drink_type.makgeolli, price: 1200, img_url: "1")
//    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var drinks = Signin_Complete().drink
    @State var review: Results<Review> = get_All_Review()
    @State var selected_drink = Drink(id: UUID(), name: "", type: .makgeolli, price: 0, img_url: "")
    
    var body: some View {
        
        let filter_drink = drinks.filter{$0.type == selected_type}
        
        GeometryReader{ geo in
            NavigationView{
                ScrollView{
                    ZStack {
                        NavigationLink(destination: Review_View(drink: selected_drink, review: review), isActive: $cliked_button, label: {
                            EmptyView()
                        })
                    }
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
//                            let filter_review = review.filter{$0.drink_name == drink.name}
                            
                            
                            }
                            .padding()
                            .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.blue, lineWidth: 4)
                                )
 
                    })
                    .padding()

                }

                .toolbar{
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
                    ToolbarItem(placement: .bottomBar, content:{
                        
                        Button(action: {
                            self.show_sheet.toggle()
                        }, label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 40))
                                .foregroundColor(Color.gray)
                        })
                    })

                }
                
            }

        }
        .sheet(isPresented: $show_sheet, onDismiss: {
            dismissed = true
        }){
            Register_Drink(drink: $drinks, show_sheet: $show_sheet)
        }

    }
}

//struct Drink_Info_Previews: PreviewProvider {
//    static var previews: some View {
//        Drink_List(selected_type: .makgeolli)
//    }
//}
