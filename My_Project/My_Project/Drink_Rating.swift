//
//  Drink_Rating.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/04.
//

import Foundation
import RealmSwift

class Drink_Rating: Object{
    
    @Persisted var name: String
    @Persisted var rating: Int8
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(name: String, rating: Int8){
        self.init()
        self.name = name
        self.rating = rating
    }
}

func add_rating(name: String, rating: Int8){
    
    let user_rating = Drink_Rating()
    
    user_rating.name = name
    user_rating.rating = rating
    
    let realm = try! Realm()
    
    try! realm.write{
        realm.add(user_rating)
    }
}

func read_rating(){
    
    let realm = try! Realm()
    print(realm.objects(Drink_Rating.self))
}
