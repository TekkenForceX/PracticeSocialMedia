//
//  HomeView.swift
//  PracticeSocialMedia
//
//  Created by Matthew Fails on 11/8/24.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let user = authViewModel.user {
                    Text("Welcome, \(user.email ?? "User")!")
                        .font(.title2)
                }

                Button("Sign Out") {
                    authViewModel.signOut()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
