//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Purnaman Rai (College) on 08/12/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    // @Query(sort: \User.name) var users: [User]
    @Query(
        filter:
            #Predicate<User> { user in
                if user.name.localizedStandardContains("R") {
                    if user.city == "London" {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            },
        sort: \User.name
    ) var users: [User]
    // @State private var navPath = [User]()

    var body: some View {
        // NavigationStack(path: $navPath) {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    Text(user.name)
                }
            }
            .navigationTitle("Users")
            // .navigationDestination(for: User.self) { selectedUser in
            //     EditUserView(user: selectedUser)
            // }
            .toolbar {
                /*
                Button("Add User", systemImage: "plus") {
                    // If you think about it, adding and editing are very similar, so the easiest thing to do here is to create a new User object with empty properties, insert it into the model context, then immediately navigate to that by adjusting the path property.
                    let emptyUser = User(name: "", city: "", joinDate: Date.now)
                    modelContext.insert(emptyUser)
                    navPath = [emptyUser]
                    // It's pretty much the same approach Apple's own Notes app takes, although they add the extra step of automatically deleting the note if you exit the editing view without actually adding any text.
                }
                 */

                Button("Add Samples", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)
                    
                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
                    
                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
