//
//  Firebase_Database.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/05/10.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

struct drink_s: Codable, Identifiable, Hashable{
    
    var id: String
    var name: String
    var price: Int64
    var drink_type: String
    var img_url: String
}

class DrinkStore: ObservableObject {
    @Published var drinks: [drink_s] = []
    @Published var changeCount: Int = 0
    
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
        
        databasePath
            .observe(.childChanged){[weak self] snapshot, _ in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else{
                    return
                }
                do{
                    let drinkData = try JSONSerialization.data(withJSONObject: json)
                    let drink = try self.decoder.decode(drink_s.self, from: drinkData)
                    
                    var index = 0
                    for drinkItem in self.drinks {
                        if (drink.id == drinkItem.id){
                            break
                        }else{
                            index += 1
                        }
                    }
                    self.drinks[index] = drink
                } catch{
                    print("an error occurred", error)
                }
            }
        
        databasePath
            .observe(.childRemoved){[weak self] snapshot in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else{
                    return
                }
                do{
                    let drinkData = try JSONSerialization.data(withJSONObject: json)
                    let drink = try self.decoder.decode(drink_s.self, from: drinkData)
                    for (index, drinkItem) in self.drinks.enumerated() where drink.id == drinkItem.id {
                        self.drinks.remove(at: index)
                    }
                } catch{
                    print("an error occurred", error)
                }
            }
        
        databasePath
            .observe(.value){[weak self] snapshot in
                guard
                    let self = self
                else {
                    return
                }
                self.changeCount += 1
            }
    }
    
    func stopListening() {
        ref?.removeAllObservers()
    }
    
    func addNewDrink(drink: drink_s) {
        self.ref?.child("drinks").child("\(drink.id)").setValue([
            "id": drink.id,
            "name": drink.name,
            "drink_type": drink.drink_type,
            "price": drink.price,
            "img_url": drink.img_url
        ])
    }
    
    func deleteDrink(key: String) {
        ref?.child("drinks/\(key)").removeValue()
    }
    
    func editDrink(drink: drink_s) {
        let updates: [String : Any] = [
            "id": drink.id,
            "drink_type": drink.drink_type,
            "price": drink.price,
            "img_url": drink.img_url
        ]
        
        let childUpdates = ["drinks/\(drink.id)": updates]
        for (index, drinkItem) in drinks.enumerated() where drinkItem.id == drink.id {
            drinks[index] = drink
        }
        self.ref?.updateChildValues(childUpdates)
        
    }
    
}
