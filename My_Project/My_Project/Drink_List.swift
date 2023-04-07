//
//  Drink_Info.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/30.
//

import SwiftUI
import Foundation

struct Drink: Identifiable{
    
    enum drink_type{
        case soju, beer, makgeolli
    }
    
    var id: UUID
    var name: String
    var type: drink_type
    var price: Int64
    var img: Image
    

}

func img_adjust(img: Image) -> some View {
    
    
    let img_ = img
                .resizable()
                .frame(width: 70, height: 70)

    
    return img_
}


struct Drink_List: View {
    
    @State var selected_type: Drink.drink_type
    @State var show_sheet: Bool = false
    @State var cliked_button: Bool = false
    
    @State private var drinks = [
        Drink(id: UUID(), name: "cham", type: Drink.drink_type.soju, price: 1950, img: Image("soju1")),
        Drink(id: UUID(), name: "cass", type: Drink.drink_type.beer, price: 1500, img: Image("beer1")),
        Drink(id: UUID(), name: "terra", type: Drink.drink_type.beer, price: 1500, img: Image("beer2")),
        Drink(id: UUID(), name: "cheoeum", type: Drink.drink_type.soju, price: 1950, img: Image("soju2")),
        Drink(id: UUID(), name: "jangsoo", type: Drink.drink_type.makgeolli, price: 1200, img: Image("makgeolli1"))
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        let filter_drink = drinks.filter{$0.type == selected_type}
        
        GeometryReader{ geo in
            NavigationView{
                ScrollView{
                    LazyVGrid(columns: columns, alignment: .center, spacing: 30, content:{
                        ForEach(filter_drink) { drink in

                                NavigationLink(destination: Review_View(), isActive: $cliked_button, label: {
                                    Button(action: {
                                        self.cliked_button.toggle()
                                    }, label: {
                                        VStack{
                                            drink.img.resizable().frame(width: geo.size.width / 3, height: geo.size.height / 6)
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
                                self.selected_type = .soju
                            }, label: {
                                Text("Soju")
                                    .foregroundColor(.black)
                            })
                            
                            Button(action: {
                                self.selected_type = .beer
                            }, label: {
                                Text("Beer")
                                    .foregroundColor(.black)
                            })
                            
                            Button(action: {
                                self.selected_type = .makgeolli
                            }, label: {
                                Text("makgeolli")
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
        Drink_List(selected_type: .soju)
    }
}
