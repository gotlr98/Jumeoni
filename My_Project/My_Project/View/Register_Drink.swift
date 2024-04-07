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
    
    @EnvironmentObject var drinkStore: DrinkStore
    
    @State var selected_type: drink.drink_type = .makgeolli
    @State var alertStat: Bool = false
    @State var input_name: String = ""
    @State var input_price: String = ""
    @State var input_img_url: String = ""
    @State var show_alert: Bool = false
    @State var is_url_valid: Bool = false
    @State var button_clicked: Bool = false
    @State var isError: Bool = false
    @Binding var drinks: [drink]
    @Binding var show_sheet: Bool
    

    
    var body: some View {
        GeometryReader{ geo in
            VStack{
                if button_clicked && !input_img_url.isEmpty{
                    
                    KFImage(URL(string: input_img_url))
                        .onFailure{ e in
                            isError = true
                        }
                        .onSuccess{ s in
                            isError = false
                        }
                        .resizable()
                        .frame(width: 80, height: 80)
                        .position(x: geo.size.width / 2, y: geo.size.height / 8)
                        .alert("URL주소 확인해주세요.", isPresented: $isError){
                            Button("OK", role: .cancel){
                                isError = false
                                button_clicked = false
                            }
                        }
                }
                
            }
            
            VStack(alignment: .center){
                
                Picker("종류", selection: $selected_type){
                    Text("막걸리").tag(drink.drink_type.makgeolli)
                    Text("증류주").tag(drink.drink_type.spirits)
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
                    button_clicked = false
                }
                
            }
            .position(x: geo.size.width / 2, y: geo.size.height / 3)
            
            
            HStack{
                Button(action: {
                    if input_img_url.isEmpty{
                        show_alert = true
                        button_clicked = true
                    }
                    else{
                        button_clicked = true
                    }
                    
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
                    if input_name.isEmpty || input_price.isEmpty || input_img_url.isEmpty{
                        show_alert = true
                    }
                    else{
                        
                        if selected_type == .makgeolli{
                            drinkStore.addNewDrink(drink: drink(id: UUID().uuidString, name: input_name, price: Int64(input_price)!, drink_type: "makgeolli", img_url: input_img_url))
                        }
                        
                        else if selected_type == .spirits{
                            drinkStore.addNewDrink(drink: drink(id: UUID().uuidString, name: input_name, price: Int64(input_price)!, drink_type: "spirits", img_url: input_img_url))
                        }
                        
                        show_sheet.toggle()
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
            .position(x: geo.size.width / 2, y: geo.size.height / 1.4)
            

        }
    }
}   
