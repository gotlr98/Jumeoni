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
    @State var makgeolli_review: [makgeolli_review] = []
    @State var spirit_review: [spirit_review] = []
    
    var body: some View {
        
        NavigationView{
            VStack{
                List{
                    Section(content: {
                        ForEach(self.makgeolli_review, id: \.self){ review in
                            VStack(alignment: .leading){
                                Text(review.user_name + "나의 리뷰: ")
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
                            .onTapGesture{}.onLongPressGesture(minimumDuration: 0.2){
                                print("press")
                            }
                        }
                        .onDelete(perform: { row in
                            for index in row{
                                user_view.deleteMakgeolliReview(review: self.makgeolli_review[index])
                                self.makgeolli_review.remove(at: index)
                            }
    //
                        })
                    }, header: {
                        Text("막걸리 리뷰")
                    })
                    
                    Section(content: {
                        ForEach(self.spirit_review, id: \.self){ review in
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
                        }
                        .onDelete(perform: { row in
                            for index in row{
                                user_view.deleteSpiritReview(review: self.spirit_review[index])
                                self.spirit_review.remove(at: index)
                            }
    //
                        })
                    }, header: {
                        Text("증류주 리뷰")
                    })
                }
                .onAppear{
                    self.makgeolli_review = user_view.getUserMakgeolliReview(user: user_view.cur_user)
                    self.spirit_review = user_view.getUserSpiritReview(user: user_view.cur_user)
                }
                .refreshable{
                    self.makgeolli_review = user_view.getUserMakgeolliReview(user: user_view.cur_user)
                    self.spirit_review = user_view.getUserSpiritReview(user: user_view.cur_user)
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
