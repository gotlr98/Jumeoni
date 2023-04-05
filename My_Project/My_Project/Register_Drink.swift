//
//  Register_Drink.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/05.
//

import SwiftUI
import Combine

struct Register_Drink: View {
    
    @State var selected_type: Drink.drink_type = Drink.drink_type.soju
    @State var alertStat: Bool = false
    @State var input_name: String = ""
    @State var input_price: String = ""
    
    var body: some View {
        
        VStack{
            Picker("종류", selection: $selected_type){
                Text("소주").tag(Drink.drink_type.soju)
                Text("맥주").tag(Drink.drink_type.beer)
                Text("막걸리").tag(Drink.drink_type.makgeolli)
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
            .onReceive(Just(input_price)){ newValue in
                let filtered = newValue.filter { "0123456789".contains($0)}
                if filtered != newValue{
                    self.input_price = filtered
                    alertStat.toggle()
                }
            }
            .alert("숫자를 입력하세요", isPresented: $alertStat){
                Button(role: .cancel){
                    
                } label:{
                    Text("Close")
                }
            }
        }
        
    }
}

struct Register_Drink_Previews: PreviewProvider {
    static var previews: some View {
        Register_Drink()
    }
}
