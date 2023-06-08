//
//  Edit_Review_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/06/05.
//

import SwiftUI

struct Edit_Makgeolli_Review_View: View {
    
    @EnvironmentObject var user_review: UserReviewStore
    @Environment(\.presentationMode) var presentation
    
    @State var review: makgeolli_review
    
    @State var sweet: Double = 0.0
    @State var bitter: Double = 0.0
    @State var sour: Double = 0.0
    @State var refreshing: Double = 0.0
    @State var thick: Double = 0.0
    @State var rating: Double = 0.0
    @State var comment: String = ""
    
    @Binding var show_sheet: Bool
    @State var show_alert: Bool = false
    

    var body: some View {
        
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
        }
        
        
        Button(action: {
            
            if comment.isEmpty{
                show_alert = true
            }
            else{
                user_review.editMakgeolliReview(user: user_review.cur_user, review: makgeolli_review(id: review.id, user_id: user_review.cur_user.id, user_name: user_review.cur_user.name, drink_name: review.drink_name, sweet: sweet, bitter: bitter, sour: sour, refreshing: refreshing, thick: thick, comment: comment, drink_type: "makgeolli", rating: rating))
//                presentation.wrappedValue.dismiss()
                show_sheet.toggle()
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
            self.sweet = review.sweet
            self.bitter = review.bitter
            self.sour = review.sour
            self.refreshing = review.refreshing
            self.thick = review.thick
            self.rating = review.rating
            self.comment = review.comment
        }
//        .toolbar(.hidden, for: .tabBar)
        
    }
}

//struct Edit_Makgeolli_Review_View_Previews: PreviewProvider {
//    static var previews: some View {
//        Edit_Makgeolli_Review_View()
//    }
//}
