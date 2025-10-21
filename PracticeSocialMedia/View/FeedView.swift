//
//  FeedView.swift
//  PracticeSocialMedia
//
//  Created by Matthew Fails on 7/23/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct FeedView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @State private var showLogoutAlert = false

    @State private var posts: [Post] = [
        Post(username: "john_doe", userProfileImage: "person.circle.fill", postImage: "sun.max.fill", caption: "Loving the sunshine! ☀️"),
        Post(username: "jane_smith", userProfileImage: "person.circle.fill", postImage: "leaf.fill", caption: "Nature walks are the best 🌿"),
        Post(username: "dev_matt", userProfileImage: "person.circle.fill", postImage: "desktopcomputer", caption: "Coding away on SwiftUI! 💻"),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach($posts) { $post in
                        PostView(post: $post)
                    }
                }
                // Optional: you can add padding if layout feels too tight
                // .padding(.horizontal)
            }
            .navigationTitle("For You")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        Label("Logout", systemImage: "person.circle.fill")
                            .frame(width: 100, height: 30)
                    }
                }
            }
            .alert("Are you sure you want to log out?", isPresented: $showLogoutAlert) {
                Button("Log out", role: .destructive) {
                    try? Auth.auth().signOut()
                    isLoggedIn = false
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}

#Preview {
    FeedView()
}
