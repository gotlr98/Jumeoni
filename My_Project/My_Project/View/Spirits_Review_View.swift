//
//  Makgeolli_Review_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/18.
//

import SwiftUI
import Cosmos
import RealmSwift

struct Stars_View: UIViewRepresentable {
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

struct Spirits_Review_View: View {
    
    @EnvironmentObject var kakao: Kakao_AuthVM
    @Binding var show_sheet: Bool
    @State var show_alert: Bool = false
    
    
    @State var scent = 1.0
    @State var bodied = 1.0
    @State var drinkability = 1.0
    @State var rating = 1.0
    @State var comment = ""
    
    var drink: Drink
    
    var body: some View{
        
        VStack{
            HStack{
                Text("단맛")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $scent)
            }
            
            HStack {
                Text("쓴맛")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $bodied)
            }
            
            HStack {
                Text("신맛")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $drinkability)
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
                print(kakao.user_name + "님")
                
                if comment.isEmpty{
                    show_alert = true
                }
                else{
                    let spirits_review = Spirits_Review(name: kakao.user_name, drink_name: drink.name, scent: scent, bodied: bodied, drinkability: drinkability, rating: rating, comment: comment)
                    set_Spirits_Review(name: kakao.user_name, drink_name: drink.name, scent: scent, bodied: bodied, drinkability: drinkability, rating: rating, comment: comment)
                    kakao.add_user_spirits_review(review: spirits_review)
                    show_sheet.toggle()
                }
                
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
            .alert("한줄평 입력해주세요", isPresented: $show_alert){
                Button("OK", role: .cancel){}
            }
        }
        
    }
}

struct Spritis_Previews: PreviewProvider {
    static var previews: some View {
        Makgeolli_Review_View(show_sheet: .constant(false), drink: Drink(id: UUID(), name: "", type: .makgeolli, price: 12, img_url: ""))
    }
}
