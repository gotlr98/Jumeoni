//
//  Firebase_Database.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/05/10.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

struct drink_s: Identifiable, Hashable, Decodable{
    
    enum drink_type{
        case makgeolli, spirits
    }
    
    var id: String
    var name: String
    var price: Int64
    var drink_type: String
    var img_url: String
}

class DrinkStore: ObservableObject {
    
    @Published var drinks: [drink_s] = []
    @Published var isListening: Bool = false
    
    let ref: DatabaseReference? = Database.database().reference() // (1)
    
    private let encoder = JSONEncoder() // (2)
    private let decoder = JSONDecoder() // (2)

    
    func listenToRealtimeDatabase() {

        guard let databasePath = ref?.child("drinks") else {
            return
        }


        databasePath
            .observe(.childAdded) { [weak self] snapshot, _ in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else {
                    return
                }
                do {
                    let drinkData = try JSONSerialization.data(withJSONObject: json)
                    let drink = try self.decoder.decode(drink_s.self, from: drinkData)
                    self.drinks.append(drink)

                } catch {
                    print("an error occurred", error)
                }
            }

//        databasePath
//            .observe(.childChanged){[weak self] snapshot, _ in
//                guard
//                    let self = self,
//                    let json = snapshot.value as? [String: Any]
//                else{
//                    return
//                }
//                do{
//                    let drinkData = try JSONSerialization.data(withJSONObject: json)
//                    let drink = try self.decoder.decode(drink_s.self, from: drinkData)
//
//                    var index = 0
//                    for drinkItem in self.drinks {
//                        if (drink.id == drinkItem.id){
//                            break
//                        }else{
//                            index += 1
//                        }
//                    }
//                    self.drinks[index] = drink
//                } catch{
//                    print("an error occurred", error)
//                }
//            }
//
//        databasePath
//            .observe(.childRemoved){[weak self] snapshot in
//                guard
//                    let self = self,
//                    let json = snapshot.value as? [String: Any]
//                else{
//                    return
//                }
//                do{
//                    let drinkData = try JSONSerialization.data(withJSONObject: json)
//                    let drink = try self.decoder.decode(drink_s.self, from: drinkData)
//                    for (index, drinkItem) in self.drinks.enumerated() where drink.id == drinkItem.id {
//                        self.drinks.remove(at: index)
//                    }
//                } catch{
//                    print("an error occurred", error)
//                }
//            }
        
//        databasePath
//            .observe(.value){[weak self] snapshot in
//                guard
//                    let self = self
//                else {
//                    return
//                }
//                self.changeCount += 1
//            }
    }
    
    func stopListening() {
        ref?.removeAllObservers()
    }
    
    func addNewDrink(drink: drink_s) {
        
//        self.drink_number += 1
//        print(self.drink_number)
        
//        self.ref?.child("drinks").observeSingleEvent(of: .value, with: { snapshot in
//            self.drink_number = snapshot.childrenCount
//        })
        
        
        let key = ref?.child("drinks").childByAutoId().key
        
        self.ref?.child("drinks").child("\(key)").setValue([
            "id": drink.id,
            "name": drink.name,
            "drink_type": drink.drink_type,
            "price": drink.price,
            "img_url": drink.img_url
        ])
        
        
//        self.objectWillChange.send()
    }

    
    func deleteDrink(key: String) {
        ref?.child("drinks/\(key)").removeValue()
    }
    
//    func editDrink(drink: drink_s) {
//        let updates: [String : Any] = [
//            "id": drink.id,
//            "drink_type": drink.drink_type,
//            "price": drink.price,
//            "img_url": drink.img_url
//        ]
//        
//        let childUpdates = ["drinks/\(self.drink_number)": updates]
//        for (index, drinkItem) in drinks.enumerated() where drinkItem.id == drink.id {
//            drinks[index] = drink
//        }
//        self.ref?.updateChildValues(childUpdates)
//        
//    }
    
    func setDrink(){
        ref?.child("drinks").observeSingleEvent(of: .value, with: { snapshot in

            for child in snapshot.children{
                let autoIdSnap = child as! DataSnapshot
                let childDict = autoIdSnap.value as! [String: Any]
                
                self.drinks.append(drink_s(id: childDict["id"] as! String, name: childDict["name"] as! String, price: childDict["price"] as! Int64, drink_type: childDict["drink_type"] as! String, img_url: childDict["img_url"] as! String))
            }
        })
    }
    
    func set_base_drink(){
        
        var drink_makgeolli_urls = [
            "https://shop-phinf.pstatic.net/20210310_33/1615366607176Lcuku_JPEG/16502386893795886_360513017.jpg?type=f296_296",
            "https://shop-phinf.pstatic.net/20191219_139/15767325002260Pgp4_JPEG/14094042834526025_302456124.jpg?type=f296_296",
            "https://shop-phinf.pstatic.net/20200110_203/1578639707946HnVE6_JPEG/16000446576448255_1930707197.jpg?type=f296_296",
            "https://shop-phinf.pstatic.net/20220308_196/1646723306901UvadW_JPEG/100193_1.jpg?type=f296_296"
        ]
        
        var drink_spirits_urls = [
            "https://shop-phinf.pstatic.net/20190809_6/sk0121@hanmail.net_15653291581585yOnx_JPEG/2689896791116560_1805883291.jpg?type=f296_296",
            "https://shop-phinf.pstatic.net/20210628_144/16248585845575Gsym_JPEG/100806_1.jpg?type=f296_296",
            "https://shop-phinf.pstatic.net/20210727_34/1627353438848GHIaN_JPEG/100631_1.jpg?type=f296_296",
            "https://shop-phinf.pstatic.net/20201224_42/1608799693244m4bcA_JPEG/100618_1.jpg?type=f296_296"
        ]
        
        addNewDrink(drink: drink_s(id: UUID().uuidString, name: "대대포 블루 꿀 막걸리", price: 3490, drink_type: "makgeolli", img_url: drink_makgeolli_urls[0]))
        addNewDrink(drink: drink_s(id: UUID().uuidString, name: "금쌀 선호 생 막걸리", price: 1900, drink_type: "makgeolli", img_url: drink_makgeolli_urls[1]))
        addNewDrink(drink: drink_s(id: UUID().uuidString, name: "정고집 옛날 생 동동주", price: 2430, drink_type: "makgeolli", img_url: drink_makgeolli_urls[2]))
        addNewDrink(drink: drink_s(id: UUID().uuidString, name: "사곡양조 공주 알밤 왕밤주", price: 1620, drink_type: "makgeolli", img_url: drink_makgeolli_urls[3]))
        addNewDrink(drink: drink_s(id: UUID().uuidString, name: "한주양조 한주 35도", price: 3490, drink_type: "spirits", img_url: drink_spirits_urls[0]))
        addNewDrink(drink: drink_s(id: UUID().uuidString, name: "바다한잔 동해소주", price: 3490, drink_type: "spirits", img_url: drink_spirits_urls[1]))
        addNewDrink(drink: drink_s(id: UUID().uuidString, name: "예산사과와인 추사백 25도", price: 3490, drink_type: "spirits", img_url: drink_spirits_urls[2]))
        addNewDrink(drink: drink_s(id: UUID().uuidString, name: "시트러스 미상 25도", price: 3490, drink_type: "spirits", img_url: drink_spirits_urls[3]))


    }

}
