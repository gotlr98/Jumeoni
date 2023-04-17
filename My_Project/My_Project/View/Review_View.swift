//
//  Review_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/05.
//

import SwiftUI
import RealmSwift

struct Review_View: View {
    
    var drink: Drink
    var review: Results<Review>
    
    var body: some View {
        VStack {
           
            List{
                ForEach(review){ review in
                    if drink.name == review.drink_name{
                        HStack{
                            Text(review.name)
                            Text(String(review.rating))
                        }
                    }

                }
            }
            .listStyle(.sidebar)

           
        }
    }
}
//
//struct Review_View_Previews: PreviewProvider {
//    static var previews: some View {
//        Review_View(drink: Drink(id: UUID(), name: "", type: .makgeolli, price: 1, img_url: ""), review: .contains([Review()]))
//    }
//}
