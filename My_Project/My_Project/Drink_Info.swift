//
//  Drink_Info.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/30.
//

import SwiftUI
import Foundation

struct Drink: Hashable, Identifiable{
    
    enum drink_type{
        case soju, beer, korean_wine
    }
    
    var id: UUID
    var type: drink_type
    var price: Int64
    

    
}

struct Drink_Info: View {
    
    @State var selected_type: Drink.drink_type
    
    @State private var drinks = [
        Drink(id: UUID(), type: Drink.drink_type.soju, price: 1350),
        Drink(id: UUID(), type: Drink.drink_type.beer, price: 1500)
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns, alignment: .center, spacing: 30, content:{
                    ForEach(drinks) { drink in
                            
                            VStack{
  
                                Image("cham")
                                    .resizable()
                                    .frame(width:70, height: 70)
                                
//                                Image()
                                    
                                HStack{
                                    Text("soju")
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
            }
        }
        
        
        
        
    }
}

struct Drink_Info_Previews: PreviewProvider {
    static var previews: some View {
        Drink_Info(selected_type: .beer)
    }
}
