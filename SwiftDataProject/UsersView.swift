//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Purnaman Rai (College) on 11/12/2025.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Query var users: [User]

    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.joinDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) { // SortDescriptor type needs to know what it's sorting, so we need to specify User inside angle brackets
        _users = Query( // // I know I defined a generic Query variable earlier, but now that the View is loading and I have this specific minimumJoinDate, I want to replace the instructions for that Query. Here are the new instructions: Filter by this specific date and sort by sortOrder.
            filter:
                #Predicate<User> { user in
                    user.joinDate >= minimumJoinDate
                },
            sort: sortOrder
        )
        
        // users: This is the final result, an array of User objects ([User]) that you display in a List.
        // _users: This is the SwiftData Query object itself. It contains the instructions on how to fetch that data (filtering, sorting, etc.)
        
        // When you declare @Query var users: [User], Swift creates a hidden storage variable named _users for you.
    }
}

#Preview {
    UsersView(minimumJoinDate: Date.now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
