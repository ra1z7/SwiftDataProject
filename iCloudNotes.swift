//
//  iCloudNotes.swift
//  SwiftDataProject
//
//  Created by Purnaman Rai (College) on 16/12/2025.
//

/*
 
 Steps to enable iCloud syncing in your app:
   1. Paid Account: You need an Apple Developer Program membership (approx $99/year) to use CloudKit.
   2. iCloud Capability: This is the main switch. It tells Apple "This app needs cloud storage."
   3. CloudKit Container: This is your specific storage locker on Apple's servers (usually named iCloud.com.yourname.appname).
   4. Background Modes (Remote Notifications): This is crucial. It allows the cloud to poke your app and say, "Hey! The user added a Job on their iPad, please update the list on this iPhone right now," even if the app is running in the background.
 
 
 
 Local SwiftData: You can be strict. You can say, "A user must have a name."
 iCloud SwiftData: You must be flexible. You cannot demand that data exists immediately.

 Why? When data syncs over the internet, it doesn't always arrive in perfect order or all at once. If your app crashes because a "Name" hasn't arrived from the server yet, the user experience is ruined. Therefore, iCloud insists that everything must be either Optional (?) or have a Default Value.
 
 
 
 Important: Although the simulator is created at testing local SwiftData applications, it's pretty terrible at testing iCloud – you might find your data isn't synchronized correctly, quickly, or even at all. Always test sync features on a real physical iPhone.
 
 */
