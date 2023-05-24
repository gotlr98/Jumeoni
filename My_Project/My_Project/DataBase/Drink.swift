////
////  Drink.swift
////  My_Project
////
////  Created by HaeSik Jang on 2023/04/10.
////
//
//import Foundation
//import SwiftUI
//import RealmSwift
//
//
//struct Drink: Identifiable, Hashable{
//
//    enum drink_type{
//        case makgeolli, spirits
//    }
//
//    var id: UUID
//    var name: String
//    var type: drink_type
//    var price: Int64
//    var img_url: String
//
//}
//
//class Drink_Store: Object{
//
//    @Persisted var name: String
//    @Persisted var price: Int64
//    @Persisted var drink_type: String
//    @Persisted var img_url: String
//    @Persisted(primaryKey: true) var objectID: ObjectId
//
//    convenience init(name: String, price: Int64, drink_type: String, img_url: String){
//        self.init()
//        self.name = name
//        self.price = price
//        self.drink_type = drink_type
//        self.img_url = img_url
//    }
//}
//
//func set_drink(name: String, price: Int64, drink_type: String, img_url: String){
//
//    let drink = Drink_Store()
//
//    drink.name = name
//    drink.price = price
//    drink.drink_type = drink_type
//    drink.img_url = img_url
//
//    let realm = try! Realm()
//
//    try! realm.write{
//        realm.add(drink)
//    }
//}
//
//func set_primary_drink(){
//
//    @State var drink_makgeolli_urls = [
//        "https://shop-phinf.pstatic.net/20210310_33/1615366607176Lcuku_JPEG/16502386893795886_360513017.jpg?type=f296_296",
//        "https://shop-phinf.pstatic.net/20191219_139/15767325002260Pgp4_JPEG/14094042834526025_302456124.jpg?type=f296_296",
//        "https://shop-phinf.pstatic.net/20200110_203/1578639707946HnVE6_JPEG/16000446576448255_1930707197.jpg?type=f296_296",
//        "https://shop-phinf.pstatic.net/20220308_196/1646723306901UvadW_JPEG/100193_1.jpg?type=f296_296"
//    ]
//
//    @State var drink_spirits_urls = [
//        "https://shop-phinf.pstatic.net/20190809_6/sk0121@hanmail.net_15653291581585yOnx_JPEG/2689896791116560_1805883291.jpg?type=f296_296",
//        "https://shop-phinf.pstatic.net/20210628_144/16248585845575Gsym_JPEG/100806_1.jpg?type=f296_296",
//        "https://shop-phinf.pstatic.net/20210727_34/1627353438848GHIaN_JPEG/100631_1.jpg?type=f296_296",
//        "https://shop-phinf.pstatic.net/20201224_42/1608799693244m4bcA_JPEG/100618_1.jpg?type=f296_296"
//    ]
//
//    set_drink(name: "대대포 블루 꿀 막걸리", price: 3490, drink_type: "makgeolli", img_url: drink_makgeolli_urls[0])
//    set_drink(name: "금쌀 선호 생 막걸리", price: 1900, drink_type: "makgeolli", img_url: drink_makgeolli_urls[1])
//    set_drink(name: "정고집 옛날 생 동동주", price: 2430, drink_type: "makgeolli", img_url: drink_makgeolli_urls[2])
//    set_drink(name: "사곡양조 공주 알밤 왕밤주", price: 1620, drink_type: "makgeolli", img_url: drink_makgeolli_urls[3])
//    set_drink(name: "한주양조 한주 35도", price: 13320, drink_type: "spirits", img_url: drink_spirits_urls[0])
//    set_drink(name: "바다한잔 동해소주", price: 2600, drink_type: "spirits", img_url: drink_spirits_urls[1])
//    set_drink(name: "예산사과와인 추사백 25도", price: 13000, drink_type: "spirits", img_url: drink_spirits_urls[2])
//    set_drink(name: "시트러스 미상 25도", price: 12350, drink_type: "spirits", img_url: drink_spirits_urls[3])
//}
//
//func get_All_Drink() -> Results<Drink_Store>{
//
//    let realm = try! Realm()
//    let result = realm.objects(Drink_Store.self)
//
//    return result
//}
//
//func remove_Drink(){
//
//    let realm = try! Realm()
//
//    try! realm.write{
//        realm.deleteAll()
//    }
//}
