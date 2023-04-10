//
//  Register_Drink.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/05.
//

import SwiftUI
import Combine

struct Register_Drink: View {
    
    @State var selected_type: Drink.drink_type = Drink.drink_type.makgeolli
    @State var alertStat: Bool = false
    @State var input_name: String = ""
    @State var input_price: String = ""
    
    var body: some View {
        
        VStack{
            Picker("종류", selection: $selected_type){
                Text("막걸리").tag(Drink.drink_type.makgeolli)
                Text("증류주").tag(Drink.drink_type.spirits)
            }
            .pickerStyle(.segmented)

            TextField(text: $input_name, label: {
                Text("술 이름")
            })
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .textInputAutocapitalization(.never)
            
            TextField(text: $input_price, label: {
                Text("가격")
            })
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .textContentType(.telephoneNumber)
            
            
        }
        
    }
}

struct Register_Drink_Previews: PreviewProvider {
    static var previews: some View {
        Register_Drink()
    }
}
