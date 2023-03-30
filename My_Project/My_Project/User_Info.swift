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

func read_user(){
    let realm = try! Realm()
    print(realm.objects(User_Info.self))
}
