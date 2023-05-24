////
////  Drink_Rating.swift
////  My_Project
////
////  Created by HaeSik Jang on 2023/04/04.
////
//
//import Foundation
//import RealmSwift
//
//class Makgeolli_Review: Object, Identifiable{
//
//    @Persisted var name: String
//    @Persisted var drink_name: String
//    @Persisted var sweet: Double
//    @Persisted var bitter: Double
//    @Persisted var sour: Double
//    @Persisted var refreshing: Double
//    @Persisted var thick: Double
//    @Persisted var rating: Double
//    @Persisted var comment: String
//    @Persisted(primaryKey: true) var objectID: ObjectId
//
//    convenience init(name: String, drink_name: String, sweet: Double, bitter: Double, sour: Double, refreshing: Double, thick: Double, rating: Double, comment: String, objectID: ObjectId) {
//        self.init()
//        self.name = name
//        self.drink_name = drink_name
//        self.sweet = sweet
//        self.bitter = bitter
//        self.sour = sour
//        self.refreshing = refreshing
//        self.thick = thick
//        self.rating = rating
//        self.comment = comment
//        self.objectID = objectID
//    }
//}
//
//func set_Makgeolli_Review(name: String, drink_name: String, sweet: Double, bitter: Double, sour: Double, refreshing: Double, thick: Double, rating: Double, comment: String){
//
//    let review = Makgeolli_Review()
//
//    review.name = name
//    review.drink_name = drink_name
//    review.sweet = sweet
//    review.bitter = bitter
//    review.sour = sour
//    review.refreshing = refreshing
//    review.thick = thick
//    review.rating = rating
//    review.comment = comment
//
//
//    let realm = try! Realm()
//
//    try! realm.write{
//        realm.add(review)
//    }
//}
//
//func get_Makgeolli_Review_By_User_Name(find_name: String) -> Results<Makgeolli_Review>{
//
//    let realm = try! Realm()
//    let result = realm.objects(Makgeolli_Review.self).filter("name == '\(find_name)'")
//
//    return result
//}
//
//func get_Makgeolli_Review_By_Drink_Name(find_name: String) -> Results<Makgeolli_Review>{
//
//    let realm = try! Realm()
//    let result = realm.objects(Makgeolli_Review.self).filter("drink_name == '\(find_name)'")
//
//    return result
//}
//
//
//func get_All_Makgeolli_Review() -> Results<Makgeolli_Review>{
//
//    let realm = try! Realm()
//    let result = realm.objects(Makgeolli_Review.self)
//    
//    return result
//}
//
//func remove_all_Makgeolli_review(){
//
//    let realm = try! Realm()
//
//    try! realm.write{
//        realm.delete(realm.objects(Makgeolli_Review.self))
//    }
//}
