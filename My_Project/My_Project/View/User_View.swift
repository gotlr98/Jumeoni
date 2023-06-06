//
//  User_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/25.
//

import SwiftUI

struct User_View: View {
    
    @EnvironmentObject var kakao: Kakao_AuthVM
    @EnvironmentObject var user_view: UserReviewStore
    @State var makgeolli_reviews: [makgeolli_review] = []
    @State var selected_makgeolli_review: makgeolli_review = makgeolli_review(id: "", user_id: 0, user_name: "", drink_name: "", sweet: 1.0, bitter: 1.0, sour: 1.0, refreshing: 1.0, thick: 1.0, comment: "", drink_type: "", rating: 1.0)
    @State var spirit_reviews: [spirit_review] = []
    @State var selected_spirit_review: spirit_review = spirit_review(id: "", user_id: 0, user_name: "", drink_name: "", scent: 1.0, bodied: 1.0, drinkability: 1.0, comment: "", drink_type: "", rating: 1.0)
    @State var isClikced: Bool = false
    @State var selected_review_type: String = ""
    
    var body: some View {
        
        NavigationView{
            VStack{
                ZStack {
                    NavigationLink(destination: selected_review_type == "makgeolli" ? AnyView(Edit_Makgeolli_Review_View(review: selected_makgeolli_review)) : AnyView(Edit_Spirits_Review_View(review: selected_spirit_review)), isActive: $isClikced, label: {
                        EmptyView()
                    })
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                }
                List{
                    Section(content: {
                        ForEach(self.makgeolli_reviews, id: \.self){ review in

                                VStack(alignment: .leading){
                                    Text("나의 리뷰: ")
                                    Text(review.drink_name + " review - ")

                                    HStack{
                                        Text("단맛 : " + String(review.sweet))
                                        Text("신맛 : " + String(review.sour))
                                        Text("쓴맛 : " + String(review.bitter))
                                        Text("청량감 : " + String(review.refreshing))
                                        Text("걸쭉함 : " + String(review.thick))

                                    }
                                    Text("총점 : " + String(review.rating))
                                    Text("코멘트 : " + review.comment)

                                }
                                .onTapGesture{}
                                .onLongPressGesture(minimumDuration: 0.5, perform: {
                                    self.isClikced = true
                                    self.selected_review_type = "makgeolli"
                                    self.selected_makgeolli_review = review
                            })
                        }
                        
                        .onDelete(perform: { row in
                            for index in row{
                                user_view.deleteMakgeolliReview(review: self.makgeolli_reviews[index])
                                self.makgeolli_reviews.remove(at: index)
                            }
                        })

                    }, header: {
                        Text("막걸리 리뷰")
                    })
                    


                    
                    Section(content: {
                        ForEach(self.spirit_reviews, id: \.self){ review in
                            VStack(alignment: .leading){
                                Text(review.user_name + "님: ")
                                Text(review.drink_name + " review - ")

                                HStack{
                                    Text("향 : " + String(review.scent))
                                    Text("바디감 : " + String(review.bodied))
                                    Text("목넘김 : " + String(review.drinkability))

                                }
                                Text("총점 : " + String(review.rating))
                                Text("코멘트 : " + review.comment)
                            }
                            .onTapGesture{}
                            .onLongPressGesture(minimumDuration: 0.5, perform: {
                                self.isClikced = true
                                self.selected_review_type = "spirit"
                                self.selected_spirit_review = review
                        })
                        }
                        .onDelete(perform: { row in
                            for index in row{
                                user_view.deleteSpiritReview(review: self.spirit_reviews[index])
                                self.spirit_reviews.remove(at: index)
                            }
    //
                        })
                    }, header: {
                        Text("증류주 리뷰")
                    })
                }

                
                
                .onAppear{
                    self.makgeolli_reviews = user_view.getUserMakgeolliReview(user: user_view.cur_user)
                    self.spirit_reviews = user_view.getUserSpiritReview(user: user_view.cur_user)
                }
                .refreshable{
                    self.makgeolli_reviews = user_view.getUserMakgeolliReview(user: user_view.cur_user)
                    self.spirit_reviews = user_view.getUserSpiritReview(user: user_view.cur_user)
                }
            }
        }
    }
}

struct User_View_Previews: PreviewProvider {
    static var previews: some View {
        User_View()
    }
}
