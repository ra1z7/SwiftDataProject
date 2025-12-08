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
    @Query(sort: \User.name) var users: [User]
    @State private var navPath = [User]()

    var body: some View {
        NavigationStack(path: $navPath) {
            List(users) { user in
                NavigationLink(value: user) {
                    Text(user.name)
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { selectedUser in
                EditUserView(user: selectedUser)
            }
            .toolbar {
                Button("Add User", systemImage: "plus") {
                    let emptyUser = User(name: "", city: "", joinDate: Date.now)
                    modelContext.insert(emptyUser)
                    navPath = [emptyUser]
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
