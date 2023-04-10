//
//  Review_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/05.
//

import SwiftUI
import RealmSwift


struct Review_View: View {
    
    var body: some View {
        VStack {
            Button(action: {
//                set_Review(name: "sik", rating: 3, comment: "good")
//                set_Review(name: "jang", rating: 2, comment: "soso", drink_type: "soju")
//                remove_all()
                
//                let review_name = get_Review_Byname(find_name: "sik")
                let all_review = get_All_Review()
//                let get_drink = get_drink_type(drink_type: "soju")
//
                    for i in all_review{
                        print(i.name, i.rating, i.comment)
                    }
//
//                for j in get_drink{
//                    print(j.name, j.rating, j.comment, j.drink_type)
//                }

                
            }, label: {
                Text("Review test")
            })
        }
    }
}

struct Review_View_Previews: PreviewProvider {
    static var previews: some View {
        Review_View()
    }
}
