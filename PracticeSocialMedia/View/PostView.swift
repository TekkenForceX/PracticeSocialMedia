//
//  PostView.swift
//  PracticeSocialMedia
//
//  Created by Matthew Fails on 7/23/25.
//

import SwiftUI

struct PostView: View {
    @Binding var post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // User Info
            HStack {
                Image(systemName: post.userProfileImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())

                Text(post.username)
                    .fontWeight(.bold)

                Spacer()
            }

            // Post Image
            Image(systemName: post.postImage)
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(10)

            // Action Buttons
            HStack(spacing: 15) {
                Button(action: {
                    post.isLiked.toggle()
                }) {
                    Image(systemName: post.isLiked ? "heart.fill" : "heart")
                        .foregroundColor(post.isLiked ? .red : .primary)
                        .font(.title2)
                }

                Image(systemName: "bubble.right")
                    .font(.title2)

                Spacer()
            }

            // Caption
            Text("\(post.username): \(post.caption)")
                .font(.subheadline)
        }.padding()
    }
}


#Preview {
    StatefulPreviewWrapper(
        Post(
            username: "preview_user",
            userProfileImage: "person.circle.fill",
            postImage: "sun.max.fill",
            caption: "This is a preview post!",
            isLiked: false
        )
    ) { postBinding in
        PostView(post: postBinding)
    }
}


struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: value)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}

