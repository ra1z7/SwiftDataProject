//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Purnaman Rai (College) on 08/12/2025.
//

import SwiftData
import SwiftUI

struct EditUserView: View {
    @Bindable var user: User // Editing with SwiftData objects is no different from editing regular @Observable classes – just with the added bonus that all our data is loaded and saved neatly!

    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate, displayedComponents: .date)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let customModelContainer = try ModelContainer(for: User.self, configurations: config)
        let sampleUser = User(
            name: "Purnaman Rai",
            city: "Kathmandu",
            joinDate: Date.now
        )

        return EditUserView(user: sampleUser)
            .modelContainer(customModelContainer)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
