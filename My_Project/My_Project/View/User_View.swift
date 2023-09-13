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
    @State var selected_makgeolli_review: makgeolli_review = makgeolli_review(id: "", user_id: "", user_name: "", drink_name: "", sweet: 1.0, bitter: 1.0, sour: 1.0, refreshing: 1.0, thick: 1.0, comment: "", drink_type: "", rating: 1.0)
    @State var spirit_reviews: [spirit_review] = []
    @State var selected_spirit_review: spirit_review = spirit_review(id: "", user_id: "", user_name: "", drink_name: "", scent: 1.0, bodied: 1.0, drinkability: 1.0, comment: "", drink_type: "", rating: 1.0)
    @State var isClicked: Bool = false
    @State var selected_review_type: String = ""
    
    var body: some View {
        
        NavigationView{
            VStack{
                List{
                    Section(content: {
                        ForEach(self.makgeolli_reviews, id: \.self){ review in
                            
                            VStack(alignment: .leading){
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
                            .contextMenu(menuItems: {
                                Button(action: {
                                    Task{
                                        self.selected_review_type = "makgeolli"
                                    }
                                    self.selected_makgeolli_review = review
                                    self.isClicked = true
                                }, label: {
                                    Text("수정하기")
                                })
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
                            .contextMenu(menuItems: {
                                Button(action: {
                                    Task{
                                        self.selected_review_type = "spirit"
                                    }
                                    self.selected_spirit_review = review
                                    self.isClicked = true
                                }, label: {
                                    Text("수정하기")
                                })
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
            .fullScreenCover(isPresented: $isClicked){
                Button(role: .cancel, action: {
                    isClicked = false
                }, label: {
                    Text("닫기")
                })
                if self.selected_review_type == "makgeolli"{
                    Edit_Makgeolli_Review_View(review: selected_makgeolli_review, show_sheet: $isClicked)
                }
                
                else if self.selected_review_type == "spirit"{
                    Edit_Spirits_Review_View(review: selected_spirit_review)
                }
                else{
                    ContentView()
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
