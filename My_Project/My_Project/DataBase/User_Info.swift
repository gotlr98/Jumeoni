//
//  User_Info.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/30.
//

import Foundation
import RealmSwift

class User_Info: Object{
    
    @Persisted var name: String
    let makgeolli_reviews = List<Makgeolli_Review>()
    let spirits_reviews = List<Spirits_Review>()
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(name: String){
        self.init()
        self.name = name
    }
}

func add_user(name: String){
    
    let user = User_Info()
    user.name = name
    
    let realm = try! Realm()
    
    try! realm.write{
        realm.add(user)
    }
}

func add_user_makgeolli_review(user: User_Info, review: Makgeolli_Review){

    let realm = try! Realm()
    
    try! realm.write{
        user.makgeolli_reviews.append(review)
    }
}

func add_user_spirits_review(user: User_Info, review: Spirits_Review){

    let realm = try! Realm()
    
    try! realm.write{
        user.spirits_reviews.append(review)
    }
}

func read_user(){
    let realm = try! Realm()
//    print(realm.objects(User_Info.self))
}

func remove_user(){
    
    let realm = try! Realm()
    
    try! realm.write{
        realm.delete(realm.objects(User_Info.self))
    }
}
