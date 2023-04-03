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
    var pruduct_name: String
    var price: Int64
    var type: drink_type
    
    
}

struct Drink_Info: View {
    
    @State private var drinks = [
        Drink(id: UUID(), pruduct_name: "cham", price: 1350, type: Drink.drink_type.soju),
        Drink(id: UUID(), pruduct_name: "cass", price: 1500, type: Drink.drink_type.beer)
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, alignment: .center, spacing: 30, content:{
                    ForEach(drinks) { drink in
                        VStack{
                            Image(drink.pruduct_name)
                                .resizable()
                                .frame(width:70, height: 70)
                            
//                            AsyncImage(url: URL(string:"https://file.hitejinro.com/hitejinro2016/upFiles/brand/KR/category/20230322_51349231.png"))
//                                .frame(maxWidth: 50, maxHeight: 50)
                                    
                            
                                
                            HStack{
                                Text(drink.pruduct_name)
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
        
    }
}

struct Drink_Info_Previews: PreviewProvider {
    static var previews: some View {
        Drink_Info()
    }
}
