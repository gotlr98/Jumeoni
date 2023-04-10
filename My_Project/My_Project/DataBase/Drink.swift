//
//  Drink.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/10.
//

import Foundation
import SwiftUI
import RealmSwift


struct Drink: Identifiable{
    
    enum drink_type{
        case soju, beer, makgeolli
    }
    
    var id: UUID
    var name: String
    var type: drink_type
    var price: Int64
    var img: Image

}

class Drink_Store: Object{
    
    
    @Persisted var name: String
    @Persisted var price: Int64
    @Persisted var drink_type: String
    @Persisted var img_url: String
    @Persisted(primaryKey: true) var objectID: ObjectId

    convenience init(name: String, price: Int64, drink_type: String, img_url: String){
        self.init()
        self.name = name
        self.price = price
        self.drink_type = drink_type
        self.img_url = img_url
    }
}

func set_drink(name: String, price: Int64, drink_type: String, img_url: String){
    
    let drink = Drink_Store()
    
    drink.name = name
    drink.price = price
    drink.drink_type = drink_type
    drink.img_url = img_url
    
    let realm = try! Realm()
    
    try! realm.write{
        realm.add(drink)
    }
}
