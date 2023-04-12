//
//  Drink.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/10.
//

import Foundation
import SwiftUI
import RealmSwift


struct Drink: Identifiable, Hashable{
    
    enum drink_type{
        case makgeolli, spirits
    }
    
    var id: UUID
    var name: String
    var type: drink_type
    var price: Int64
    var img_url: String

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

func set_primary_drink(){
    
    @State var drink_urls = [
        "https://cdn.aflnews.co.kr/news/photo/202009/202082_41658_5018.jpg",
        "https://www.soolsool.co.kr/html/soolsool/_images/sub/product_slowly_n2.jpg",
        "https://biz.chosun.com/resizer/8TSIJXQK22BnhKs8QHMw2eAUOiM=/333x470/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/TNQAYESGCMTCH5A2LW25OYLWWY.jpg",
        "https://www.joeunsulsj.co.kr:5009/admode/upload/product/37/main_736946901640741471.jpg"
    ]
    
    set_drink(name: "jangsoo", price: 1300, drink_type: "makgeolli", img_url: drink_urls[0])
    set_drink(name: "neurinmaeul", price: 2000, drink_type: "makgeolli", img_url: drink_urls[1])
    set_drink(name: "jipyeong", price: 1600, drink_type: "makgeolli", img_url: drink_urls[2])
    set_drink(name: "albam", price: 2100, drink_type: "makgeolli", img_url: drink_urls[3])
}

func get_All_Drink() -> Results<Drink_Store>{
    
    let realm = try! Realm()
    let result = realm.objects(Drink_Store.self)
    
    return result
}

func remove_Drink(){
    
    let realm = try! Realm()
    
    try! realm.write{
        realm.deleteAll()
    }
}
