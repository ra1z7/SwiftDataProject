//
//  Job.swift
//  SwiftDataProject
//
//  Created by Purnaman Rai (College) on 14/12/2025.
//

import Foundation
import SwiftData

// Auto-Migration: If you already have an app on the App Store with just a User model, and you release an update adding Job, SwiftData will update the database on your user's phones automatically without crashing.

@Model
class Job {
    var name: String
    var priority: Int
    var owner: User? // Each Job belongs to One User (Many-to-One Relationship)
    // owner property is optional because a job might be created before it is assigned to a user.
    
    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}
