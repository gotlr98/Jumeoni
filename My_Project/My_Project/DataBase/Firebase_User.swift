//
//  Firebase_Database.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/05/10.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

struct user_s: Codable, Identifiable, Hashable{
    
    var id: String
    var name: String
    var email: String
}

class UserStore: ObservableObject {
    
    @Published var user_review: [user_s: [review_s]] = [:]
    
    let ref: DatabaseReference? = Database.database().reference() // (1)
    
    private let encoder = JSONEncoder() // (2)
    private let decoder = JSONDecoder() // (2)
    
    func listenUserDataBase() {
        
        guard let databasePath = ref?.child("users") else {
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
                    let userData = try JSONSerialization.data(withJSONObject: json)
                    let user = try self.decoder.decode(user_s.self, from: userData)
                    self.user_review[user_s(id: UUID().uuidString, name: user.name, email: user.email)] = [review_s(id: "", user_name: "", drink_name: "", comment: "", drink_type: "", rating: 0)]
                    
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
//                    let userData = try JSONSerialization.data(withJSONObject: json)
//                    let user = try self.decoder.decode(user_s.self, from: userData)
//
//                    var index = 0
//                    for userItem in self.user_review {
//                        if (user.id == userItem.id){
//                            break
//                        }else{
//                            index += 1
//                        }
//                    }
//                    self.users[index] = user
//                } catch{
//                    print("an error occurred", error)
//                }
//            }
        
        databasePath
            .observe(.childRemoved){[weak self] snapshot in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else{
                    return
                }
                do{
                    let userData = try JSONSerialization.data(withJSONObject: json)
                    let user = try self.decoder.decode(user_s.self, from: userData)
                    for (index, userItem) in self.users.enumerated() where user.id == userItem.id {
                        self.users.remove(at: index)
                    }
                } catch{
                    print("an error occurred", error)
                }
            }
        
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
    
    func addNewUser(user: user_s) {
        self.ref?.child("users").child("\(user.id)").setValue([
            "id": user.id,
            "name": user.name,
            "email": user.email,
        ])
        
    }
    
    
    func deleteUser(key: String) {
        ref?.child("users/\(key)").removeValue()
    }
    
//    func editUser(user: user_s) {
//        let updates: [String : Any] = [
//            "id": user.id,
//            "name": user.name,
//            "email": user.email,
//        ]
//        
//        let childUpdates = ["users/\(user.id)": updates]
//        for userItem in user_review.keys where userItem.id == user.id {
//            user_review.removeValue(forKey: userItem)
//            user_review[userItem]
//        }
//        self.ref?.updateChildValues(childUpdates)
//        
//    }
}
