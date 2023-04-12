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
    
    @State var drink = Signin_Complete().drink
    
    var body: some View {
        
        let filter_drink = drink.filter{$0.type == selected_type}
        
        GeometryReader{ geo in
            NavigationView{
                ScrollView{
                    LazyVGrid(columns: columns, alignment: .center, spacing: 10, content:{
                        ForEach(filter_drink) { drink in
                                NavigationLink(destination: Review_View(), isActive: $cliked_button, label: {
                                    Button(action: {
                                        self.cliked_button.toggle()
                                    }, label: {
                                        
                                        VStack{

                                            KFImage(URL(string: drink.img_url))
                                                .placeholder{
                                                    Color.gray
                                                }.retry(maxCount: 3, interval: .seconds(5))
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
            Register_Drink(drink: $drink, show_sheet: $show_sheet)
            
        }
        
    }
}

struct Drink_Info_Previews: PreviewProvider {
    static var previews: some View {
        Drink_List(selected_type: .makgeolli)
    }
}
