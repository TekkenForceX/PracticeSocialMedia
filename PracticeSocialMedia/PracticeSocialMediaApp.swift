//
//  PracticeSocialMediaApp.swift
//  PracticeSocialMedia
//
//  Created by Matthew Fails on 5/24/24.
//

import SwiftUI
import Firebase

@main
struct PracticeSocialMediaApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
