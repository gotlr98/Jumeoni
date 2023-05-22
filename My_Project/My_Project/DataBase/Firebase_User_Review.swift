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
    var name: String
    var drink_name: String
    var comment: String
    var drink_type: String
    var rating: Int8

}

class UserReviewStore: ObservableObject {
    
    @Published var users: [user_s] = []
    @Published var reviews: [review_s] = []
    @Published var changeCount: Int = 0
    
    let ref: DatabaseReference? = Database.database().reference() // (1)
    
    private let encoder = JSONEncoder() // (2)
    private let decoder = JSONDecoder() // (2)
    
    func listenToRealtimeDatabase() {
        
        guard let databasePath = ref?.child("reviews") else {
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
                    let review = try self.decoder.decode(review_s.self, from: reviewData)
                    self.reviews.append(review)
                    
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
                    let review = try self.decoder.decode(review_s.self, from: reviewData)
                    
                    var index = 0
                    for reviewItem in self.reviews {
                        if (review.id == reviewItem.id){
                            break
                        }else{
                            index += 1
                        }
                    }
                    self.reviews[index] = review
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
                    let review = try self.decoder.decode(review_s.self, from: reviewData)
                    for (index, reviewItem) in self.reviews.enumerated() where review.id == reviewItem.id {
                        self.reviews.remove(at: index)
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
    
    func addNewReview(review: review_s) {
        self.ref?.child("reviews").child("\(review.id)").setValue([
            "id": review.id,
            "name": review.name,
            "drink_type": review.drink_type,
            "drink_name": review.drink_name,
            "comment": review.comment,
            "rating": review.rating
        ])
        
    }
    
    
    func deleteReview(key: String) {
        ref?.child("reviews/\(key)").removeValue()
    }
    
    func editReview(review: review_s) {
        let updates: [String : Any] = [
            "id": review.id,
            "name": review.name,
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
}
