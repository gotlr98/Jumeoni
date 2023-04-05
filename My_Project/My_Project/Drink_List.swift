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
        case soju, beer, korean_wine
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
    
    @State private var drinks = [
        Drink(id: UUID(), name: "cham", type: Drink.drink_type.soju, price: 1350, img: Image("soju1")),
        Drink(id: UUID(), name: "cass", type: Drink.drink_type.beer, price: 1500, img: Image("beer1"))
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

                                VStack{
                                    drink.img.resizable().frame(width: geo.size.width / 3, height: geo.size.height / 6)
                                    
                                                                        
                                    HStack{
                                        Text(drink.name)
                                        Text(String(drink.price))
                                    }
                                }

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
                        Menu("Create"){
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
                        }
                        
                        
                    })
                    
                    ToolbarItem(placement: .bottomBar, content:{
                        Button(action: {
                            self.show_sheet.toggle()
                        }, label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 40))
                            
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
