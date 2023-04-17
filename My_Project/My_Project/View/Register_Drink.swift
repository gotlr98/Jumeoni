//
//  Register_Drink.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/05.
//

import SwiftUI
import Combine
import Kingfisher



struct Register_Drink: View {
    
    @State var selected_type: Drink.drink_type = Drink.drink_type.makgeolli
    @State var alertStat: Bool = false
    @State var input_name: String = ""
    @State var input_price: String = ""
    @State var input_img_url: String = ""
    @State var show_alert: Bool = false
    @State var is_url_valid: Bool = false
    @State var button_clicked: Bool = false
    @Binding var drink: [Drink]
    @Binding var show_sheet: Bool
    
    func register_drink(id: UUID, name: String, type: Drink.drink_type, price: Int64, img_url: String){

            drink.append(Drink(id: UUID(), name: name, type: type, price: Int64(price), img_url: img_url))
            switch type {
            case .makgeolli:
                set_drink(name: name, price: Int64(price), drink_type: "makgeolli", img_url: img_url)
            case .spirits:
                set_drink(name: name, price: Int64(price), drink_type: "spirits", img_url: img_url)
            }
            self.is_url_valid = true
            
    }
    
    var body: some View {
        
        GeometryReader{ geo in
            VStack(alignment: .center){
                
                if button_clicked{
                    KFImage(URL(string: input_img_url))
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                
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
                .keyboardType(.numbersAndPunctuation)
                
                TextField(text: $input_img_url, label: {
                    Text("이미지 링크")
                })
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .textInputAutocapitalization(.never)
                .onChange(of: input_img_url){ newValue in
                    if input_img_url != newValue{
                        button_clicked = false
                    }
                }
                
            }
            .position(x: geo.size.width / 2, y: geo.size.height / 3)
            
            
            HStack{
                Button(action: {
                    button_clicked = true
                }, label: {
                    Rectangle()
                        .frame(width: 100, height: 50)
                        .foregroundColor(Color.secondary)
                        .overlay{
                            Text("이미지 확인")
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                        }
                })
                Button(action: {
                    register_drink(id: UUID(), name: input_name, type: selected_type, price: Int64(input_price)!, img_url: input_img_url)
                    show_sheet.toggle()
 
                }, label: {
                    Rectangle()
                        .frame(width: 80, height: 50)
                        .foregroundColor(Color.secondary)
                        .overlay{
                            Text("등록")
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                        }
                })
//                .alert("이미지 URL을 확인해주세요", isPresented: $show_alert){
//                    Button("OK", role: .cancel){}
//                }
                
            }
            .position(x: geo.size.width / 2, y: geo.size.height / 1.6)

        }
        
        
    }
}
//
//struct Register_Drink_Previews: PreviewProvider {
//    static var previews: some View {
////        Register_Drink(drink: $drink)
//    }
//}
