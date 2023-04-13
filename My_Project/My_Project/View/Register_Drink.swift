//
//  Register_Drink.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/05.
//

import SwiftUI
import Combine
import Kingfisher

func check_url_valid(url: String) -> Bool{
    var isVaild: Bool = false
    
    
    KFImage(URL(string: url))
        .placeholder{
            Color.gray
        }
        .retry(maxCount: 5, interval: .seconds(5))
        .onSuccess{ s in
            isVaild = true
        }
        .onFailure{ e in
            isVaild = false
        }
    
    return isVaild
}

struct Register_Drink: View {
    
    @State var selected_type: Drink.drink_type = Drink.drink_type.makgeolli
    @State var alertStat: Bool = false
    @State var input_name: String = ""
    @State var input_price: String = ""
    @State var input_img_url: String = ""
    @State var show_alert: Bool = false
    @State var is_url_valid: Bool = false
    @Binding var drink: [Drink]
    @Binding var show_sheet: Bool
    
    
    var body: some View {
        
        GeometryReader{ geo in
            VStack(alignment: .center){
                
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
                
            }
            .position(x: geo.size.width / 2, y: geo.size.height / 3)
            
            VStack{
                Button(action: {
//                    KFImage(URL(string: input_img_url))
//                        .onSuccess {r in //성공
//                            is_url_valid = true
//                            print("success \(r)")
//                        }
//                        .onFailure { e in //실패
//                            show_alert = true
//                            print("failure: \(e)")
//                        }

                    if check_url_valid(url: input_img_url){
                        drink.append(Drink(id: UUID(), name: input_name, type: selected_type, price: Int64(input_price)!, img_url: input_img_url))
                        for i in get_All_Drink(){
                          print(i)
                        }
                        switch selected_type {
                        case .makgeolli:
                            set_drink(name: input_name, price: Int64(input_price)!, drink_type: "makgeolli", img_url: input_img_url)
                        case .spirits:
                            set_drink(name: input_name, price: Int64(input_price)!, drink_type: "spirits", img_url: input_img_url)
                        }
                        show_sheet.toggle()
                    }
                    else{
                        show_alert = true
                    }
                    
                    
  
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
                .alert("이미지 URL을 확인해주세요", isPresented: $show_alert){
                    Button("OK", role: .cancel){}
                }
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
