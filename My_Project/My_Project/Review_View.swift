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
    @Persisted var drink_type: String
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(name: String, rating: Int8, commnet: String, drink_type: String){
        self.init()
        self.name = name
        self.rating = rating
        self.comment = comment
        self.drink_type = drink_type
    }
}

func get_drink_type() -> [String]{
    let realm = try! Realm()
    let get = realm.objects(Review.self)
    
    var result: [String] = []
    
    for i in get{
        result.append(i.drink_type)
    }
    
    return result
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

func get_Review_Byname(find_name: String) -> Results<Review>{
    
    let realm = try! Realm()
    let result = realm.objects(Review.self).filter("name == '\(find_name)'")
    
    return result
}

func get_All_Review() -> Results<Review>{
    
    let realm = try! Realm()
    let result = realm.objects(Review.self)
    
    return result
}

struct Review_View: View {
    
    var body: some View {
        VStack {
            Button(action: {
//                set_Review(name: "sik", rating: 3, comment: "good")
//                set_Review(name: "hae", rating: 2, comment: "soso")
                
                
                let review_name = get_Review_Byname(find_name: "sik")
                let all_review = get_All_Review()
                
    //                for i in review_name{
    //                    print(i.name, i.rating, i.comment)
    //                }
                
                for j in all_review{
                    print(j.name, j.rating, j.comment)
                }
                
                
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
