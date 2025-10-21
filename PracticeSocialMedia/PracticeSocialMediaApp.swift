//
//  PracticeSocialMediaApp.swift
//  PracticeSocialMedia
//
//  Created by Matthew Fails on 5/24/24.
//

import SwiftUI
import FirebaseCore

@main
struct YourApp: App {
    @StateObject var authViewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if authViewModel.isSignedIn {
                HomeView()
                    .environmentObject(authViewModel)
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
    }
}
