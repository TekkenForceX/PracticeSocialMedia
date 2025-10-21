//
//  LoginView.swift
//  PracticeSocialMedia
//
//  Created by Matthew Fails on 5/24/24.
//

//import SwiftUI
//import PhotosUI
//import Firebase
//import FirebaseFirestore
//import FirebaseStorage
//
//struct LoginView: View {
//    @State var emailID: String = ""
//    @State var password: String = ""
//    @State var createAccount: Bool = false
//    @State var showError: Bool = false
//    @State var errorMessage: String = ""
////    @State private var isLoggedIn: Bool = false
//    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
//
//
//    let user = ""
//    var body: some View {
//        VStack(spacing: 10) {
//            Text("Already have an account with us?")
//                .font(.largeTitle.bold())
//                .hAlign(.center)
//            
//            Text("Welcome Back!")
//                .font(.title3)
//                .hAlign(.center)
//            
//            VStack(spacing: 12) {
//                TextField("Email", text: $emailID)
//                    .textContentType(.emailAddress)
//                    .border(1, .gray.opacity(0.5))
//                    .padding(.top, 25)
//                
//                SecureField("Password", text: $password)
//                    .textContentType(.emailAddress)
//                    .border(1, .gray.opacity(0.5))
//                
//                Button("Reset password?", action: resetPassword)
//                    .font(.callout)
//                    .fontWeight(.medium)
//                    .tint(.black)
//                    .hAlign(.trailing)
//                
//                Button(action: loginUser) {
//                    //Mark: Login Button
//                    Text("Sign in")
//                        .foregroundColor(.white)
//                        .hAlign(.center)
//                        .fillView(.black)
//                }
//                .padding(.top, 5)
//            }
//            
//            
//            HStack {
//                Text("Don't have an account?")
//                    .foregroundColor(.gray)
//                
//                Button("Regsister Now") {
//                    createAccount.toggle()
//                    
//                }
//                .fontWeight(.bold)
//                .foregroundColor(.black)
//            }
//            .font(.callout)
//            .vAlign(.bottom)
//        }
//        .vAlign(.top)
//        .padding(15)
//
//        .fullScreenCover(isPresented: $createAccount) {
//            RegisterView()
//        }
//        // Displaying Alert
//        .alert(errorMessage, isPresented: $showError, actions: {})
//        
//        .fullScreenCover(isPresented: $isLoggedIn) {
//            FeedView()
//        }
//
//        
//    }
//
//    
//    
//    func loginUser(){
//        Task {
//            do {
//                try await Auth.auth().signIn(withEmail: emailID, password: password)
//                print("User Found")
//                await MainActor.run {
//                    isLoggedIn = true
//                }
//            } catch {
//                await setError(error)
//            }
//        }
//    }
//
//    
//    func resetPassword() {
//        Task {
//            do {
//                // With The Help of Swift Concurrency Auth Can Be Done With Single Line
//                try await Auth.auth().sendPasswordReset(withEmail: emailID)
//                print("Link Sent")
//            } catch {
//                await setError(error)
//            }
//        }
//    }
//    
//    // Displaying Errors VIA Alert
//    func setError(_ error: Error) async {
//        // UI Must Be Updated On Main Thread
//        await MainActor.run(body: {
//            errorMessage = error.localizedDescription
//            showError.toggle()
//        })
//    }
//}
////  Regsiter View
//struct RegisterView: View {
//    // User Details
//    @State var emailID: String = ""
//    @State var password: String = ""
//    @State var userName: String = ""
//    @State var userBio: String = ""
//    @State var userBioLink: String = ""
//    @State var userProfilePicData: Data?
//    // View Properties
//    @Environment(\.dismiss) var dismiss
//    @State var showImagePicker: Bool = false
//    @State var photoItem: PhotosPickerItem?
//    @State var showError: Bool = false
//    @State var errorMessage: String = ""
//    var body: some View {
//        VStack(spacing: 10) {
//            Text("Register Your\n    Account!")
//                .font(.largeTitle.bold())
//                .hAlign(.center)
//            
//            Text("Welcome!")
//                .font(.title3)
//                .hAlign(.center)
//            
//            // For Smaller Size Optimization
//            ViewThatFits {
//                ScrollView(.vertical, showsIndicators: false) {
//                    HelperView()
//                }
//                
//                HelperView()
//            }
//            
//            // Register Button
//            HStack {
//                Text("Already have an account?")
//                    .foregroundColor(.gray)
//                
//                Button("Login Now") {
//                    dismiss()
//                    
//                }
//                .fontWeight(.bold)
//                .foregroundColor(.black)
//            }
//            .font(.callout)
//            .vAlign(.bottom)
//        }
//        .vAlign(.top)
//        .padding(15)
//        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
//        .task(id: photoItem) {
//            guard let newValue = photoItem else { return }
//            
//            do {
//                guard let imageData = try await newValue.loadTransferable(type: Data.self) else { return }
//                
//                // UI Must Be Updated On Main Thread
//                await MainActor.run {
//                    userProfilePicData = imageData
//                }
//            } catch {
//                // Handle the error appropriately
//                print("Error loading image data: \(error)")
//            }
//        }
//        
//        
//        //        .onChange(of: photoItem) { newValue in
//        //            // Mark: Extracting UIImage From PhotoItem
//        //            if let newValue {
//        //                Task {
//        //                    do {
//        //                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else{return}
//        //                        // Mark: UI Must Be Updated On Main Thread
//        //                        await MainActor.run(body: {
//        //                            userProfilePicData = imageData
//        //                        })
//        //                    }catch{}
//        //                }
//        //            }
//        //        }
//        
//        // Displaying Alert
//        .alert(errorMessage, isPresented: $showError, actions: {})
//    }
//    
//    
//    @ViewBuilder
//    func HelperView()->some View {
//        VStack(spacing: 12) {
//            ZStack {
//                if let userProfilePicData, let image = UIImage(data: userProfilePicData) {
//                    Image(uiImage: image)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                } else {
//                    Image("NoProfilePic")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                }
//            }
//            .frame(width: 150, height: 150)
//            .clipShape(Circle())
//            .contentShape(Circle())
//            .onTapGesture {
//                showImagePicker.toggle()
//            }
//            .padding(.top, 5)
//            
//            TextField("Username", text: $userName)
//                .textContentType(.emailAddress)
//                .border(1, .gray.opacity(0.5))
//                .padding(.top, 25)
//            
//            TextField("Email", text: $emailID)
//                .textContentType(.emailAddress)
//                .border(1, .gray.opacity(0.5))
//            
//            SecureField("Password", text: $password)
//                .textContentType(.emailAddress)
//                .border(1, .gray.opacity(0.5))
//            
//            TextField("About You", text: $userBio, axis: .vertical)
//                .frame(minHeight: 100, alignment: .top)
//                .textContentType(.emailAddress)
//                .border(1, .gray.opacity(0.5))
//                .padding(.top,25)
//            
//            TextField("Bio Link (Optional)", text: $userBioLink)
//                .textContentType(.emailAddress)
//                .border(1, .gray.opacity(0.5))
//                .padding(.top,25)
//            
//            
//            
//            Button(action: registerUser) {
//                // Login Button
//                Text("Sign up")
//                    .foregroundColor(.white)
//                    .hAlign(.center)
//                    .fillView(.black)
//            }
//            .disableWithOpacity(userName == "" || userBio == "" || emailID == "" || password == "" || userProfilePicData == nil)
//            .padding(.top, 10)
//        }
//    }
//    func registerUser() {
//        Task {
//            do {
//                // Step 1: Creating Firebase Account
//                try await Auth.auth().createUser(withEmail: emailID, password: password)
//                // Step 2: Uploading Profile Photo Into Firebase Storage
//                guard let userUID = Auth.auth().currentUser?.uid else{return}
//                guard let imageData = userProfilePicData else{return}
//                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
//                let _ = try await storageRef.putDataAsync(imageData)
//                // Step 3: Downloading Photo URL
//                let downloadURL = try await storageRef.downloadURL()
//                // Step 4: Creating A User Firestore Object
//                let user = User(username: userName, userBio: userBio, userBioLink: userBioLink, userUID: userUID, userEmail: emailID, userProfileURL: downloadURL)
//                // Step 5: Saving User Doc Into Firestore Database
//                let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion: {
//                    error in
//                    if error == nil {
//                        // Mark: Print Saved Successfully
//                        print("Saved Successfully")
//                    }
//                })
//            }catch {
//                // Mark: Delete Acocunt In The Event Of Failure
//                //                try await Auth.auth().currentUser?.delete()
//                await setError(error)
//            }
//        }
//    }
//    // Mark: Displaying Errors VIA Alert
//    func setError(_ error: Error) async {
//        // Mark: UI Musk Be Updated On Main Thread
//        await MainActor.run(body: {
//            errorMessage = error.localizedDescription
//            showError.toggle()
//        })
//    }
//}
//
//
//
//
//
//
//#Preview {
//    LoginView()
//}
//
//// Mark: View Extensions For UI Building
extension View {
    // Mark: Disabling with Opacity
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    
    func hAlign(_ alignment: Alignment) ->some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) ->some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    // Mark: Custom Border View With Padding
    func border(_ width: CGFloat,_ color: Color) -> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
    
    // Mark: Custom Fill View With Padding
    func fillView(_ color: Color) -> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color)
            }
    }
}




import SwiftUI
import Firebase

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var emailID = ""
    @State private var password = ""
    @State private var createAccount = false
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 5) {
            Text("Already have an account with us?")
                .font(.largeTitle.bold())
                .hAlign(.center)
            
            Text("Welcome Back!")
                .font(.title3)
                .hAlign(.center)
            
            VStack(spacing: 12) {
                TextField("Email", text: $emailID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .border(1, .gray.opacity(0.5))
                
                if let error = authViewModel.authError {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button("Reset password?", action: resetPassword)
                    .font(.callout)
                    .fontWeight(.medium)
                    .tint(.black)
                    .hAlign(.trailing)
                
                Button {
                    Task {
                        await authViewModel.signIn(email: emailID, password: password)
                    }
                } label: {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .fillView(.black)
                }
                .disabled(emailID.isEmpty || password.isEmpty)
                .padding(.top, 5)
            }
            
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                
                Button("Register Now") {
                    createAccount.toggle()
                }
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        .fullScreenCover(isPresented: $createAccount) {
            RegisterView()
                .environmentObject(authViewModel)
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
        .fullScreenCover(isPresented: $authViewModel.isSignedIn) {
            FeedView()
                .environmentObject(authViewModel)
        }
    }

    func resetPassword() {
        Task {
            do {
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("Password reset email sent.")
            } catch {
                await MainActor.run {
                    errorMessage = error.localizedDescription
                    showError.toggle()
                }
            }
        }
    }
}

import SwiftUI
import PhotosUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var emailID = ""
    @State private var password = ""
    @State private var userName = ""
    @State private var userBio = ""
    @State private var userBioLink = ""
    @State private var userProfilePicData: Data?
    
    @State private var showImagePicker = false
    @State private var photoItem: PhotosPickerItem?
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Register Your\n    Account!")
                .font(.largeTitle.bold())
                .hAlign(.center)
            
            Text("Welcome!")
                .font(.title3)
                .hAlign(.center)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 12) {
                    ZStack {
                        if let userProfilePicData, let image = UIImage(data: userProfilePicData) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            Image("NoProfilePic")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .contentShape(Circle())
                    .onTapGesture { showImagePicker.toggle() }
                    .padding(.top, 5)
                    
                    TextField("Username", text: $userName)
                        .border(1, .gray.opacity(0.5))
                        .padding(.top, 25)
                    
                    TextField("Email", text: $emailID)
                        .border(1, .gray.opacity(0.5))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .border(1, .gray.opacity(0.5))
                    
                    TextField("About You", text: $userBio, axis: .vertical)
                        .frame(minHeight: 100, alignment: .top)
                        .border(1, .gray.opacity(0.5))
                        .padding(.top, 25)
                    
                    TextField("Bio Link (Optional)", text: $userBioLink)
                        .border(1, .gray.opacity(0.5))
                        .padding(.top, 25)
                    
                    Button {
                        Task {
                            let userData: [String: Any] = [
                                "username": userName,
                                "userBio": userBio,
                                "userBioLink": userBioLink,
                                "userEmail": emailID
                            ]
                            await authViewModel.signUp(
                                email: emailID,
                                password: password,
                                userData: userData,
                                profileImageData: userProfilePicData
                            )
                        }
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .hAlign(.center)
                            .fillView(.black)
                    }
                    .disableWithOpacity(userName.isEmpty || userBio.isEmpty || emailID.isEmpty || password.isEmpty)
                    .padding(.top, 10)
                }
            }
            
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.gray)
                Button("Login Now") { dismiss() }
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .task(id: photoItem) {
            guard let newValue = photoItem else { return }
            do {
                guard let imageData = try await newValue.loadTransferable(type: Data.self) else { return }
                await MainActor.run { userProfilePicData = imageData }
            } catch {
                print("Image load error:", error.localizedDescription)
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel(preview: true))
}

