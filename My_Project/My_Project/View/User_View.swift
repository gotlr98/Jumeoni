//
//  User_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/25.
//

import SwiftUI

struct User_View: View {
    
    @EnvironmentObject var kakao: Kakao_AuthVM
    
    var body: some View {
//        Button(action: {
//            print(kakao.user)
//        }, label: {
//            Text("check")
//        })
        
        
        VStack{
            List{
                ForEach(kakao.user.makgeolli_reviews, id: \.self){ review in
                    VStack(alignment: .leading){
                        Text(review.name + "님: ")
                        Text(" " + review.drink_name + "review")

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
