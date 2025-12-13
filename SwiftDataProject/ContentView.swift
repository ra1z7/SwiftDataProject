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
            // The syntax for this is a little odd at first, mostly because this is actually another macro behind the scenes - Swift converts our predicate code into a series of rules it can apply to the underlying database that stores all of SwiftData's objects.
        #Predicate<User> { user in // That predicate gives us a single user instance to check. In practice that will be called once for each user loaded by SwiftData, and we need to return true if that user should be included in the results.
            
            // user.name.localizedStandardContains("R") && user.city == "London"
            
            // These predicates support a limited subset of Swift expressions that make reading a little easier:
            
            // if user.name.contains("R") { // The contains() method is case-sensitive, use .localizedStandardContains() instead
            if user.name.localizedStandardContains("R") {
                if user.city == "London" {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
            
            /*
             // Following code is not valid, because even though it looks like we're executing pure Swift code, it's important you remember that doesn't actually happen – the #Predicate macro actually rewrites our code to be a series of tests it can apply on the database, which doesn't use Swift internally. To see inside, right-click on #Predicate and select Expand Macro, and you'll see, a huge amount of code appears. Remember, this is the actual code that gets built and run – it's what our #Predicate gets converted into. This stuff looks easy, but it's really complex behind the scenes!
             
             if user.name.localizedStandardContains("R") {
             if user.city == "London" {
             return true
             }
             }
             */
        },
        sort: \User.name
    ) var users: [User]
    // @State private var navPath = [User]()
    
    @State private var isShowingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    
    var body: some View {
        // NavigationStack(path: $navPath) {
        NavigationStack {
            UsersView(minimumJoinDate: isShowingUpcomingOnly ? Date.now : Date.distantPast, sortOrder: sortOrder)
                .navigationTitle("Users")
                .navigationDestination(for: User.self) { selectedUser in
                    EditUserView(user: selectedUser)
                }
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
                        // When working with sample data like below, it's helpful to be able to delete existing data before adding the sample data.
                        try? modelContext.delete(model: User.self) // Tells SwiftData to delete all existing model objects of User type, which means the database is clear before we add the sample users.
                        
                        let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                        let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                        let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                        let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
                        
                        let allUsers = [first, second, third, fourth]
                        for user in allUsers {
                            modelContext.insert(user)
                        }
                    }
                    
                    Button(isShowingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                        withAnimation {
                            isShowingUpcomingOnly.toggle()
                        }
                    }
                    .contentTransition(.numericText())
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        // Compare the results between using Menu view and not using it.
                        Picker("Sort", selection: $sortOrder.animation()) {
                            Text("Sort By Name")
                                .tag([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.joinDate)
                                ])
                            
                            Text("Sort By Join Date")
                                .tag([
                                    SortDescriptor(\User.joinDate),
                                    SortDescriptor(\User.name)
                                    
                                ])
                            
                            Text("Sort By City")
                                .tag([
                                    SortDescriptor(\User.city),
                                    SortDescriptor(\User.name)
                                ])
                            // tag() lets us attach specific values of our choosing to each picker option. Here that means we can literally make the tag of each option its own SortDescriptor array, and SwiftUI will assign that tag to the sortOrder property automatically.
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
