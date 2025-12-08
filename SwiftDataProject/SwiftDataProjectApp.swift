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
    }
}
