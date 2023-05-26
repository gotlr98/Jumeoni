//
//  Firebase_Database.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/05/10.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

struct user: Codable, Identifiable, Hashable{
    
    var id: String
    var name: String
    var email: String
}

struct makgeolli_review: Codable, Identifiable, Hashable{
    
    var id: String
    var user_id: String
    var user_name: String
    var drink_name: String
    var sweet: Double
    var bitter: Double
    var sour: Double
    var refreshing: Double
    var thick: Double
    var comment: String
    var drink_type: String
    var rating: Double

}

class UserReviewStore: ObservableObject {
    
    @Published var users: [user] = []
    @Published var makgeolli_reviews: [makgeolli_review] = []
    
    let ref: DatabaseReference? = Database.database().reference() // (1)
    
    private let encoder = JSONEncoder() // (2)
    private let decoder = JSONDecoder() // (2)
    
//    func listenUserDataBase() {
//
//        guard let databasePath = ref?.child("users") else {
//            return
//        }
        
        
//        databasePath
//            .observe(.childAdded) { [weak self] snapshot, _ in
//                guard
//                    let self = self,
//                    let json = snapshot.value as? [String: Any]
//                else {
//                    return
//                }
//                do {
//                    let userData = try JSONSerialization.data(withJSONObject: json)
//                    let user = try self.decoder.decode(user_s.self, from: userData)
//                    self.user_review[user_s(id: UUID().uuidString, name: user.name, email: user.email)] = [review_s(id: "", user_name: "", drink_name: "", comment: "", drink_type: "", rating: 0)]
//
//                } catch {
//                    print("an error occurred", error)
//                }
//            }
        
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
        
//        databasePath
//            .observe(.childRemoved){[weak self] snapshot in
//                guard
//                    let self = self,
//                    let json = snapshot.value as? [String: Any]
//                else{
//                    return
//                }
//                do{
//                    let userData = try JSONSerialization.data(withJSONObject: json)
//                    let user = try self.decoder.decode(user_s.self, from: userData)
//                    for (index, userItem) in self.users.enumerated() where user.id == userItem.id {
//                        self.users.remove(at: index)
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
//    }
    
//    func stopListening() {
//        ref?.removeAllObservers()
//    }
    
    func addNewUser(user: user) {
        self.ref?.child("users").child("\(user.id)").setValue([
            "id": user.id,
            "name": user.name,
            "email": user.email,
        ])
        
        self.users.append(user)
        
    }
    
    func addNewMakgeolliReview(user: user, review: makgeolli_review) {
        self.ref?.child("makgeolli_reviews").child("\(review.id)").setValue([
            "id": review.id,
            "user_id": user.id,
            "user_name": review.user_name,
            "drink_name": review.drink_name,
            "sweet" : review.sweet,
            "bitter": review.bitter,
            "sour": review.sour,
            "refreshing": review.refreshing,
            "thick": review.thick,
            "comment": review.comment,
            "drink_type": review.drink_type,
            "rating": review.rating
        ])
    }
    
    
    func deleteUser(user: user) {
        ref?.child("users/\(user.id)").removeValue()
        
        for (index, userItem) in users.enumerated() where user.id == userItem.id{
            users.remove(at: index)
        }
    }
    
    func deleteMakgeolliReview(review: makgeolli_review) {
        ref?.child("makgeolli_reviews/\(review.id)").removeValue()
        
    }
    
    func editMakgeolliReview(user: user, review: makgeolli_review) {
        let updates: [String : Any] = [
            "id": review.id,
            "user_id": user.id,
            "user_name": review.user_name,
            "drink_name": review.drink_name,
            "sweet" : review.sweet,
            "bitter": review.bitter,
            "sour": review.sour,
            "refreshing": review.refreshing,
            "thick": review.thick,
            "comment": review.comment,
            "drink_type": review.drink_type,
            "rating": review.rating
        ]
        
        let childUpdates = ["makgeolli_reviews/\(review.id)": updates]

        self.ref?.updateChildValues(childUpdates)
        
        getMakgeolliReviewFromDatabase()

    }
    
    func getUserMakgeolliReview(user: user) -> [makgeolli_review]{
        
        var temp_index: [makgeolli_review] = []
        
        for item in makgeolli_reviews where item.user_id == user.id{
            temp_index.append(item)
        }
        
        return temp_index
    }
    
    func getMakgeolliReviewFromDatabase(){
        
        ref?.child("makgeolli_reviews").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children{
                let autoIdSnap = child as! DataSnapshot
                let childDict = autoIdSnap.value as! [String: Any]
                self.makgeolli_reviews.append(makgeolli_review(id: childDict["id"] as! String, user_id: childDict["user_id"] as! String, user_name: childDict["user_name"] as! String, drink_name: childDict["drink_name"] as! String, sweet: childDict["sweet"] as! Double, bitter: childDict["bitter"] as! Double, sour: childDict["sour"] as! Double, refreshing: childDict["refreshing"] as! Double, thick: childDict["thick"] as! Double, comment: childDict["comment"] as! String, drink_type: childDict["drink_type"] as! String, rating: childDict["rating"] as! Double))
            }
        })
        
    }
    
    func getSpiritsReview() -> [makgeolli_review]{
        
        var temp_index: [makgeolli_review] = []
        
        for item in makgeolli_reviews where item.drink_type == "spirits"{
            temp_index.append(item)
        }
        
        return temp_index
    }
    
    
}
