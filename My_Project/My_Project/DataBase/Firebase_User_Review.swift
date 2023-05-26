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

struct review_s: Codable, Identifiable, Hashable{
    
    var id: String
    var user_id: String
    var user_name: String
    var drink_name: String
    var comment: String
    var drink_type: String
    var rating: Int8

}

class UserReviewStore: ObservableObject {
    
    @Published var users: [user_s] = []
    @Published var reviews: [review_s] = []
    
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
    
    func addNewUser(user: user_s) {
        self.ref?.child("users").child("\(user.id)").setValue([
            "id": user.id,
            "name": user.name,
            "email": user.email,
        ])
        
        self.users.append(user)
        
    }
    
    func addNewReview(user: user_s, review: review_s) {
        self.ref?.child("reviews").child("\(review.id)").setValue([
            "id": review.id,
            "user_id": user.id,
            "name": review.user_name,
            "drink_type": review.drink_type,
            "drink_name": review.drink_name,
            "comment": review.comment,
            "rating": review.rating
        ])
        
        self.reviews.append(review)
    }
    
    
    func deleteUser(user: user_s) {
        ref?.child("users/\(user.id)").removeValue()
        
        for (index, userItem) in users.enumerated() where user.id == userItem.id{
            users.remove(at: index)
        }
    }
    
    func deleteReview(review: review_s) {
        ref?.child("reviews/\(review.id)").removeValue()
        
        for (index, reviewItem) in reviews.enumerated() where review.id == reviewItem.id{
            reviews.remove(at: index)
        }
        
    }
    
    func editReview(user: user_s, review: review_s) {
        let updates: [String : Any] = [
            "id": review.id,
            "user_id": user.id,
            "name": review.user_name,
            "drink_type": review.drink_type,
            "drink_name": review.drink_name,
            "comment": review.comment,
            "rating": review.rating
        ]
        
        let childUpdates = ["reviews/\(review.id)": updates]
        for (index, reviewItem) in reviews.enumerated() where reviewItem.id == review.id {
            reviews[index] = review
        }
        self.ref?.updateChildValues(childUpdates)

    }
    
    func getUserReview(user: user_s) -> [review_s]{
        
        var temp_index: [review_s] = []
        
        for item in reviews where item.user_id == user.id{
            temp_index.append(item)
        }
        
        return temp_index
    }
    
    func getMakgeolliReview() -> [review_s]{
        
        var temp_index: [review_s] = []
        
        for item in reviews where item.drink_type == "makgeolli"{
            temp_index.append(item)
        }
        
        return temp_index
    }
    
    func getSpiritsReview() -> [review_s]{
        
        var temp_index: [review_s] = []
        
        for item in reviews where item.drink_type == "spirits"{
            temp_index.append(item)
        }
        
        return temp_index
    }
    
    
}
