//
//  Makgeolli_Review_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/18.
//

import SwiftUI
import Cosmos

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
    @EnvironmentObject var user_review: UserReviewStore

    @Binding var show_sheet: Bool
    @State var show_alert: Bool = false
    
    
    @State var scent = 1.0
    @State var bodied = 1.0
    @State var drinkability = 1.0
    @State var rating = 1.0
    @State var comment = ""
    
    var drink: drink
    
    var body: some View{
        
        VStack{
            HStack{
                Text("향")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $scent)
            }
            
            HStack {
                Text("바디감")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $bodied)
            }
            
            HStack {
                Text("목넘김")
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
                    
                    user_review.addNewSpiritReview(user: user_review.cur_user, review: spirit_review(id: UUID().uuidString, user_id: user_review.cur_user.id, user_name: user_review.cur_user.name, drink_name: drink.name, scent: scent, bodied: bodied, drinkability: drinkability, comment: comment, drink_type: "spirits", rating: rating))
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

struct Spirits_Review_View_Previews: PreviewProvider {
    static var previews: some View {
        Spirits_Review_View(show_sheet: .constant(false), drink: drink(id: UUID().uuidString, name: "", price: 0, drink_type: "", img_url: ""))
    }
}
