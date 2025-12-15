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
    var name: String = "Anonymous"
    var city: String = "Unknown"
    var joinDate: Date = Date.now
    @Relationship(deleteRule: .cascade) var jobs: [Job]? = [Job]() // One User can have Many Jobs (One-to-Many Relationship)
    /*
     When we don't use @Relationship macro, it's default deleteRule (rule that describes how related objects should be handled when their owning object is deleted) option is .nullify, meaning when you delete the user, the jobs stay in the database, but their owner is set to nil (This is a smart move from SwiftData, because you don't get any surprise data loss). The problem is you might end up with thousands of "orphan" jobs that belong to nobody, cluttering your databse.
     
     If you specifically want a user's all job objects to be deleted when the user itself is deleted, we need to tell SwiftData explicitly by providing it with a deleteRule of .cascade, which means deleting a User should automatically delete all their Job objects.
    */
    
    // Even after we add a jobs property (there are users that don't have that property initially), the next time our app launches, SwiftData will silently add the jobs property to all its existing users, giving them an empty array by default.
    
    // This is called a migration: when we add or delete properties in our models, as our needs evolve over time. SwiftData can do simple migrations like this one automatically, but as you progress further you'll learn how you can create custom migrations to handle bigger model changes.
    
    var unwrappedJobs: [Job] {
        jobs ?? []
    }

    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
