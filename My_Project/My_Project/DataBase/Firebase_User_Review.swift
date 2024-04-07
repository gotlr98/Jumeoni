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
    
    let id: String
    var name: String
    var email: String
}

struct makgeolli_review: Codable, Identifiable, Hashable{
    
    let id: String
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

struct spirit_review: Codable, Identifiable, Hashable{
    
    let id: String
    var user_id: String
    var user_name: String
    var drink_name: String
    var scent: Double
    var bodied: Double
    var drinkability: Double
    var comment: String
    var drink_type: String
    var rating: Double

}

class UserReviewStore: ObservableObject {
    
    @Published var users: [user_s] = []
    @Published var cur_user: user_s = user_s(id: "", name: "", email: "")
    @Published var base_user: user_s = user_s(id: "", name: "베이스", email: "base@naver,com")
    @Published var makgeolli_reviews: [makgeolli_review] = []
    @Published var temp_makgeolli_reviews: [makgeolli_review] = []
    @Published var spirit_reviews: [spirit_review] = []
    @Published var temp_spirit_reviews: [spirit_review] = []
    
    @Published var isMakgeolliListening: Bool = false
    @Published var isSpiritListening: Bool = false
    
    let ref: DatabaseReference? = Database.database().reference() // (1)
    
    private let encoder = JSONEncoder() // (2)
    private let decoder = JSONDecoder() // (2)
    
    func makgeolliListen() {

        guard let databasePath = ref?.child("makgeolli_reviews") else {
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
                    let reviewData = try JSONSerialization.data(withJSONObject: json)
                    let review = try self.decoder.decode(makgeolli_review.self, from: reviewData)
                    self.makgeolli_reviews.append(review)

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
                    let reviewData = try JSONSerialization.data(withJSONObject: json)
                    let review = try self.decoder.decode(makgeolli_review.self, from: reviewData)

                    var index = 0
                    for reviewItem in self.makgeolli_reviews {
                        if (review.id == reviewItem.id){
                            break
                        }else{
                            index += 1
                        }
                    }
                    self.makgeolli_reviews[index] = review
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
                    let reviewData = try JSONSerialization.data(withJSONObject: json)
                    let review = try self.decoder.decode(makgeolli_review.self, from: reviewData)
                    for (index, reviewItem) in self.makgeolli_reviews.enumerated() where review.id == reviewItem.id {
                        self.makgeolli_reviews.remove(at: index)
                    }
                } catch{
                    print("an error occurred", error)
                }
            }
    }
    
    func spiritListen() {

        guard let databasePath = ref?.child("spirit_reviews") else {
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
                    let reviewData = try JSONSerialization.data(withJSONObject: json)
                    let review = try self.decoder.decode(spirit_review.self, from: reviewData)
                    self.spirit_reviews.append(review)

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
                    let reviewData = try JSONSerialization.data(withJSONObject: json)
                    let review = try self.decoder.decode(spirit_review.self, from: reviewData)

                    var index = 0
                    for reviewItem in self.spirit_reviews {
                        if (review.id == reviewItem.id){
                            break
                        }else{
                            index += 1
                        }
                    }
                    self.spirit_reviews[index] = review
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
                    let reviewData = try JSONSerialization.data(withJSONObject: json)
                    let review = try self.decoder.decode(spirit_review.self, from: reviewData)
                    for (index, reviewItem) in self.spirit_reviews.enumerated() where review.id == reviewItem.id {
                        self.spirit_reviews.remove(at: index)
                    }
                } catch{
                    print("an error occurred", error)
                }
            }

    }
    
    func stopListening() {
        ref?.removeAllObservers()
    }
    
    func addNewUser(user: user_s){
            self.ref?.child("users").child("\(user.id)").setValue([
                "id": user.id,
                "name": user.name,
                "email": user.email,
            ])
    }
    
    func deleteUser(user: user_s) {
        ref?.child("users/\(user.id)").removeValue()
        
        for (index, userItem) in users.enumerated() where user.id == userItem.id{
            users.remove(at: index)
        }
    }
    
    func getUserFromDatabase(){
        ref?.child("users").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children{
                let autoIdSnap = child as! DataSnapshot
                let childDict = autoIdSnap.value as! [String: Any]
                self.users.append(user_s(id: childDict["id"] as! String, name: childDict["name"] as! String, email: childDict["email"] as! String))
            }
        })
    }
    
    func addNewMakgeolliReview(user: user_s, review: makgeolli_review) {
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
    
    func editMakgeolliReview(user: user_s, review: makgeolli_review) {
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
        

    }
    
    func deleteMakgeolliReview(review: makgeolli_review) {
        ref?.child("makgeolli_reviews/\(review.id)").removeValue()
    }
    
    func getUserMakgeolliReview(user: user_s) -> [makgeolli_review]{
        
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
                self.temp_makgeolli_reviews.append(makgeolli_review(id: childDict["id"] as! String, user_id: childDict["user_id"] as! String, user_name: childDict["user_name"] as! String, drink_name: childDict["drink_name"] as! String, sweet: childDict["sweet"] as! Double, bitter: childDict["bitter"] as! Double, sour: childDict["sour"] as! Double, refreshing: childDict["refreshing"] as! Double, thick: childDict["thick"] as! Double, comment: childDict["comment"] as! String, drink_type: childDict["drink_type"] as! String, rating: childDict["rating"] as! Double))
            }
        })
        
    }
    
    func addNewSpiritReview(user: user_s, review: spirit_review) {
        self.ref?.child("spirit_reviews").child("\(review.id)").setValue([
            "id": review.id,
            "user_id": user.id,
            "user_name": review.user_name,
            "drink_name": review.drink_name,
            "scent": review.scent,
            "bodied": review.bodied,
            "drinkability": review.drinkability,
            "comment": review.comment,
            "drink_type": review.drink_type,
            "rating": review.rating
        ])
        
    }
    
    func editSpiritReview(user: user_s, review: spirit_review) {
        let updates: [String : Any] = [
            "id": review.id,
            "user_id": user.id,
            "user_name": review.user_name,
            "drink_name": review.drink_name,
            "scent": review.scent,
            "bodied": review.bodied,
            "drinkability": review.drinkability,
            "comment": review.comment,
            "drink_type": review.drink_type,
            "rating": review.rating
        ]
        
        let childUpdates = ["spirit_reviews/\(review.id)": updates]

        self.ref?.updateChildValues(childUpdates)
        

    }
    
    func deleteSpiritReview(review: spirit_review) {
        ref?.child("spirit_reviews/\(review.id)").removeValue()
    }
    
    func getUserSpiritReview(user: user_s) -> [spirit_review]{
        
        var temp_index: [spirit_review] = []
        
        for item in spirit_reviews where item.user_id == user.id{
            temp_index.append(item)
        }
        
        return temp_index
    }
    
    func getSpiritReviewFromDatabase(){
        
        ref?.child("spirit_reviews").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children{
                let autoIdSnap = child as! DataSnapshot
                let childDict = autoIdSnap.value as! [String: Any]
                self.temp_spirit_reviews.append(spirit_review(id: childDict["id"] as! String, user_id: childDict["user_id"] as! String, user_name: childDict["user_name"] as! String, drink_name: childDict["drink_name"] as! String, scent: childDict["scent"] as! Double, bodied: childDict["bodied"] as! Double, drinkability: childDict["drinkability"] as! Double, comment: childDict["comment"] as! String, drink_type: childDict["drink_type"] as! String, rating: childDict["rating"] as! Double))
            }
        })
        
    }
