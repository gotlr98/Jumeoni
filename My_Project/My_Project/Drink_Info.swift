//
//  Drink_Info.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/30.
//

import SwiftUI

struct Drink: Hashable, Identifiable{
    var id: UUID
    var pruduct_name: String
    var price: Int64
}

struct Drink_Info: View {
    
    @State private var drinks = [
        Drink(id: UUID(), pruduct_name: "cham", price: 1350),
        Drink(id: UUID(), pruduct_name: "cass", price: 1500)
    ]
    
    let columns = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ScrollView(){
            LazyVGrid(columns: columns, alignment: .center, spacing: 30, content:{
                    ForEach(drinks) { drink in
                        VStack{
                            Image(drink.pruduct_name)
                                .resizable()
                                .frame(width:50, height: 50)
                            HStack{
                                Text(drink.pruduct_name)
                                Text(String(drink.price))
                            }
                        }
                        
                    }
            })
            
        }
        
    }
}

struct Drink_Info_Previews: PreviewProvider {
    static var previews: some View {
        Drink_Info()
    }
}
