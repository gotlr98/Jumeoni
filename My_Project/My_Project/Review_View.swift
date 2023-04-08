//
//  Review_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/05.
//

import SwiftUI
import RealmSwift

class Review: Object{
    
    @Persisted var name: String
    @Persisted var rating: Int8
    @Persisted var comment: String
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(name: String, rating: Int8, commnet: String){
        self.init()
        self.name = name
        self.rating = rating
        self.comment = comment
    }
}

func set_Review(name: String, rating: Int8, comment: String){
    let review = Review()
    
    review.name = name
    review.rating = rating
    review.comment = comment
    
    let realm = try! Realm()
    
    try! realm.write{
        realm.add(review)
    }
}

func get_Review(find_name: String) -> Results<Review>{
    
    let realm = try! Realm()
    let result = realm.objects(Review.self).filter("name == '\(find_name)'")
    
    return result
}

struct Review_View: View {
    
    var body: some View {
        VStack {
            Button(action: {
//                set_Review(name: "sik", rating: 3, comment: "good")
                
                let review = get_Review(find_name: "sik")
                print(review.first?.rating)
                
                
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
