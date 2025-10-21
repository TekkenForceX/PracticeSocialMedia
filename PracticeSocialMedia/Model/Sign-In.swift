//
//  Sign-In.swift
//  PracticeSocialMedia
//
//  Created by Matthew Fails on 10/15/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User? = nil
    @Published var isSignedIn: Bool = false
    @Published var authError: String? = nil

    init() {
        self.user = Auth.auth().currentUser
        self.isSignedIn = user != nil
    }

    func signIn(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.user = result.user
            self.isSignedIn = true
            self.authError = nil
        } catch {
            self.authError = error.localizedDescription
        }
    }

    func signUp(email: String, password: String, userData: [String: Any], profileImageData: Data?) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            guard let userUID = result.user.uid as String? else { return }

            // Upload profile image if provided
            var imageURL: URL? = nil
            if let data = profileImageData {
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                _ = try await storageRef.putDataAsync(data)
                imageURL = try await storageRef.downloadURL()
            }

            // Save Firestore user
            var updatedUserData = userData
            if let imageURL = imageURL {
                updatedUserData["profileImageURL"] = imageURL.absoluteString
            }

            try await Firestore.firestore().collection("Users").document(userUID).setData(updatedUserData)

            self.user = result.user
            self.isSignedIn = true
            self.authError = nil
        } catch {
            self.authError = error.localizedDescription
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isSignedIn = false
        } catch {
            self.authError = error.localizedDescription
        }
    }
}


extension AuthViewModel {
    convenience init(preview: Bool) {
        self.init()
        if preview {
            self.user = nil
            self.isSignedIn = false
            self.authError = nil
        }
    }
}
