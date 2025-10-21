//
//  ContentView.swift
//  PracticeSocialMedia
//
//  Created by Matthew Fails on 5/24/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        Group {
            if authViewModel.isSignedIn {
                SplashView()
            } else {
                SplashView()
            }
        }
//        SplashView()
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
