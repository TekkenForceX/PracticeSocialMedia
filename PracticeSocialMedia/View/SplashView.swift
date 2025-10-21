//
//  SplashView.swift
//  PracticeSocialMedia
//
//  Created by Matthew Fails on 7/28/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        if isActive {
            // Navigate based on login status
            if isLoggedIn {
                FeedView()
            } else {
                LoginView()
            }
            
        } else {
            VStack {
                Image(systemName: "bolt.fill") // Replace with your logo asset
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.black)

                Text("Lightning Bolt")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear {
                // Delay splash for animation or loading (e.g., Firebase check)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
