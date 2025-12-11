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

    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(
            filter:
                #Predicate<User> { user in
                    user.joinDate >= minimumJoinDate
                },
            sort: sortOrder
        )
    }
}

#Preview {
    UsersView(minimumJoinDate: Date.now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
