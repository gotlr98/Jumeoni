//
//  Drink_Rating.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/04.
//

import Foundation
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

func get_drink_type(drink_type: String) -> Results<Review>{
    
    let realm = try! Realm()
    let get = realm.objects(Review.self).filter("drink_type == '\(drink_type)'")
    
    return get
}

func set_Review(name: String, rating: Int8, comment: String, drink_type: String){
    
    let review = Review()
    
    review.name = name
    review.rating = rating
    review.comment = comment
    review.drink_type = drink_type
    
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

func remove_all(){
    
    let realm = try! Realm()
    
    try! realm.write{
        realm.deleteAll()
    }
}
