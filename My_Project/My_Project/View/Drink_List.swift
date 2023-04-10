//
//  Drink_Info.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/30.
//

import SwiftUI
import Foundation

struct Drink_List: View {
    
    @State var selected_type: Drink.drink_type = .makgeolli
    @State var show_sheet: Bool = false
    @State var cliked_button: Bool = false
    
    @State private var drinks = [
        Drink(id: UUID(), name: "cham", type: Drink.drink_type.makgeolli, price: 1950, img_url: "1"),
        Drink(id: UUID(), name: "cass", type: Drink.drink_type.makgeolli, price: 1500, img_url: "1"),
        Drink(id: UUID(), name: "terra", type: Drink.drink_type.makgeolli, price: 1500, img_url: "1"),
        Drink(id: UUID(), name: "cheoeum", type: Drink.drink_type.makgeolli, price: 1950, img_url: "1"),
        Drink(id: UUID(), name: "jangsoo", type: Drink.drink_type.makgeolli, price: 1200, img_url: "1")
    ]

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
                    LazyVGrid(columns: columns, alignment: .center, spacing: 30, content:{
                        ForEach(filter_drink) { drink in
//                                Button(action: {
//                                    print(self.drink)
//                                }, label: {
//                                    Text("1")
//                                    Text("1")
//                                })
                                NavigationLink(destination: Review_View(), isActive: $cliked_button, label: {
                                    Button(action: {
                                        self.cliked_button.toggle()
                                    }, label: {
                                        VStack{
                                            AsyncImage(url:URL(string: drink.img_url)){image in
                                                image
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                            } placeholder: {
                                                Color.gray
                                            }

                                                Text(drink.name)
                                                .foregroundColor(Color.black)
                                                .font(.system(size: 20))
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
        .sheet(isPresented: $show_sheet){
            Register_Drink()
        }
    }
}

struct Drink_Info_Previews: PreviewProvider {
    static var previews: some View {
        Drink_List(selected_type: .makgeolli)
    }
}
