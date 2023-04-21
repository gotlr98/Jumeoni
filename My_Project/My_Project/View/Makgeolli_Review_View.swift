//
//  Makgeolli_Review_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/18.
//

import SwiftUI
import Cosmos

struct MyCosmosView: UIViewRepresentable {
    @Binding var rating: Double
    

    func makeUIView(context: Context) -> CosmosView {
        CosmosView()
    }

    func updateUIView(_ uiView: CosmosView, context: Context) {
        uiView.rating = rating
    
        // Autoresize Cosmos view according to it intrinsic size
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      
        // Change Cosmos view settings here
        uiView.settings.starSize = 40
        uiView.didFinishTouchingCosmos = { rating in
            self.rating = rating
        }
    }
}

struct Makgeolli_Review_View: View {
    
    @Binding var show_sheet: Bool
    var name: String
    
    @State var sweet = 0.0
    @State var bitter = 0.0
    @State var sour = 0.0
    @State var refreshing = 0.0
    @State var thick = 0.0
    @State var rating = 0.0
    @State var comment = ""
    
    var drink: Drink
    
    var body: some View{
        
        VStack{
            HStack{
                Text("단맛")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $sweet)
            }
            
            HStack {
                Text("쓴맛")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $bitter)
            }
            
            HStack {
                Text("신맛")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $sour)
            }
            
            HStack {
                Text("청량감")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $refreshing)
            }
            
            HStack {
                Text("걸쭉함")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $thick)
            }
            Divider()
            
            HStack {
                Text("총점")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $rating)
            }
            
            HStack(alignment: .center) {
                Text("한줄평")
                    .font(.title)
                    .padding(.all)
                TextField(text: $comment, label:{
                    Text("한줄평 입력해주세요")
                })
                .frame(width: 250)
                .textInputAutocapitalization(.never)
            }
            
            Button(action: {
                print(name + "님")
                set_Makgeolli_Review(name: name, drink_name: drink.name, sweet: sweet, bitter: bitter, sour: sour, refreshing: refreshing, thick: thick, rating: rating, comment: comment)
                show_sheet.toggle()
            }, label: {
                Rectangle()
                    .frame(width: 120, height: 50)
                    .foregroundColor(Color.secondary)
                    .overlay{
                        Text("리뷰 등록하기")
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                    }
            })
        }
        
    }
}

struct Makgeolli_Review_View_Previews: PreviewProvider {
    static var previews: some View {
        Makgeolli_Review_View(show_sheet: .constant(false), name: "", drink: Drink(id: UUID(), name: "", type: .makgeolli, price: 12, img_url: ""))
    }
}
