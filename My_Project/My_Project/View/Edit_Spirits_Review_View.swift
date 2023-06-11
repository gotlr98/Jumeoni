//
//  Edit_Spirits_Review_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/06/06.
//

import SwiftUI

struct Edit_Spirits_Review_View: View {
    
    @EnvironmentObject var kakao: Kakao_AuthVM
    @EnvironmentObject var user_review: UserReviewStore

    @State var show_alert: Bool = false
    
    @State var review: spirit_review
    
    @State var scent = 1.0
    @State var bodied = 1.0
    @State var drinkability = 1.0
    @State var rating = 1.0
    @State var comment = ""
    
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
                
                if comment.isEmpty{
                    show_alert = true
                }
                else{
                    user_review.editSpiritReview(user: user_review.cur_user, review: spirit_review(id: review.id, user_id: user_review.cur_user.id, user_name: user_review.cur_user.name, drink_name: review.drink_name, scent: scent, bodied: bodied, drinkability: drinkability, comment: comment, drink_type: "spirits", rating: rating))
                }
                
            }, label: {
                Rectangle()
                    .frame(width: 120, height: 50)
                    .foregroundColor(Color.secondary)
                    .overlay{
                        Text("수정하기")
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                    }
            })
            .alert("한줄평 입력해주세요", isPresented: $show_alert){
                Button("OK", role: .cancel){}
            }
            .onAppear{
                self.bodied = review.bodied
                self.drinkability = review.drinkability
                self.scent = review.scent
                self.comment = review.comment
                self.rating = review.rating
            }
        }
    }
}

//struct Edit_Spirits_Review_View_Previews: PreviewProvider {
//    static var previews: some View {
//        Edit_Spirits_Review_View()
//    }
//}
