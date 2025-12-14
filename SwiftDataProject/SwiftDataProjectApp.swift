//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Purnaman Rai (College) on 08/12/2025.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
        // You only pass User.self to the model container. You don't need to pass Job.self. SwiftData looks at User, sees it links to Job, and sets up the database for Job automatically.
    }
}
