//
//  User.swift
//  SwiftDataProject
//
//  Created by Purnaman Rai (College) on 08/12/2025.
//

import Foundation
import SwiftData

// SwiftData's model objects are powered by the same observation system that makes @Observable classes work, which means changes to your model objects are automatically picked up by SwiftUI so that our data and our user interface stay in sync.
@Model
class User {
    var name: String
    var city: String
    var joinDate: Date

    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
