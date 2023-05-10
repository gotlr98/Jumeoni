//
//  Firebase_Database.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/05/10.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

struct drink: Codable, Identifiable, Hashable{
    
    var id: UUID
    var name: String
    var price: Int64
    var drink_type: String
    var img_url: String
}

class DrinkStore: ObservableObject{
    
    @Published var drinks: [drink] = []
    
    let ref: DatabaseReference? = Database.database().reference()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
}
