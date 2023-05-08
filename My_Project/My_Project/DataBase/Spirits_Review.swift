//
//  Drink_Rating.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/04.
//

import Foundation
import RealmSwift

class Spirits_Review: Object, Identifiable{
    
    @Persisted var name: String
    @Persisted var drink_name: String
    @Persisted var scent: Double
    @Persisted var bodied: Double
    @Persisted var drinkability: Double
    @Persisted var rating: Double
    @Persisted var comment: String
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(name: String, drink_name: String, scent: Double, bodied: Double, drinkability: Double, rating: Double, comment: String) {
        self.init()
        self.name = name
        self.drink_name = drink_name
        self.scent = scent
        self.bodied = bodied
        self.drinkability = drinkability
        self.rating = rating
        self.comment = comment
    }
}

func set_Spirits_Review(name: String, drink_name: String, scent: Double, bodied: Double, drinkability: Double, rating: Double, comment: String){
    
    let review = Spirits_Review()
    
    review.name = name
    review.drink_name = drink_name
    review.scent = scent
    review.bodied = bodied
    review.drinkability = drinkability
    review.rating = rating
    review.comment = comment
    
    
    let realm = try! Realm()
    
    try! realm.write{
        realm.add(review)
    }
}

func get_Spirits_Review_By_User_Name(find_name: String) -> Results<Spirits_Review>{
    
    let realm = try! Realm()
    let result = realm.objects(Spirits_Review.self).filter("name == '\(find_name)'")
    
    return result
}

func get_Spirits_Review_By_Drink_Name(find_name: String) -> Results<Spirits_Review>{
    
    let realm = try! Realm()
    let result = realm.objects(Spirits_Review.self).filter("drink_name == '\(find_name)'")
    
    return result
}


func get_All_Spirits_Review() -> Results<Spirits_Review>{
    
    let realm = try! Realm()
    let result = realm.objects(Spirits_Review.self)
    
    return result
}

func remove_all_Spirits_review(){
    
    let realm = try! Realm()
    
    try! realm.write{
        realm.delete(realm.objects(Spirits_Review.self))
    }
}
