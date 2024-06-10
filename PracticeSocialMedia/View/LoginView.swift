//
//  LoginView.swift
//  PracticeSocialMedia
//
//  Created by Matthew Fails on 5/24/24.
//

import SwiftUI

struct LoginView: View {
    //Mark: User Details
    @State var emailID: String = ""
    @State var password: String = ""
    //Mark: View Properties
    @State var createAccount: Bool = false
    var body: some View {
        VStack(spacing: 10) {
            Text("Corata!")
                .font(.largeTitle.bold())
                .hAlign(.center)
            
            Text("Welcome Back!")
                .font(.title3)
                .hAlign(.center)
            
            VStack(spacing: 12) {
                TextField("Email", text: $emailID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top,25)
                
                SecureField("Password", text: $password)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                
                Button("Reset password?", action: {})
                    .font(.callout)
                    .fontWeight(.medium)
                    .tint(.black)
                    .hAlign(.trailing)
                
                Button {
                    
                } label: {
                    //Mark: Login Button
                Text("Sign in")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .fillView(.black)
                }
                .padding(.top, 10)
            }
            
            // Mark Register Button
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                
                Button("Regsister Now") {
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
        //Mark: Register View VIA Sheets
        .fullScreenCover(isPresented: $createAccount) {
            RegisterView()
        }
                
        }
    }
//Mark: Regsiter View
struct RegisterView: View {
    //Mark: User Details
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var userBio: String = ""
    @State var userBioLink: String = ""
    @State var userProfilePicData: Data?
    //Mark: View Properties
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 10) {
            Text("Register Your\n    Account!")
                .font(.largeTitle.bold())
                .hAlign(.center)
            
            Text("Welcome!")
                .font(.title3)
                .hAlign(.center)
            
            //Mark For Smaller Size Optimization
            ViewThatFits {
                ScrollView(.vertical, showsIndicators: false) {
                    HelperView()
                }
                
                HelperView()
            }
            
            // Mark Register Button
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.gray)
                
                Button("Login Now") {
                    dismiss()
                    
                }
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
    }
    
    @ViewBuilder
    func HelperView()->some View {
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
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .contentShape(Circle())
            .padding(.top,25)
            
            TextField("Username", text: $userName)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
                .padding(.top,25)
            
            TextField("Email", text: $emailID)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            SecureField("Password", text: $password)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            TextField("About You", text: $userBio, axis: .vertical)
                .frame(minHeight: 100, alignment: .top)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
                .padding(.top,25)
            
            TextField("Bio Link (Optional)", text: $userBioLink)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
                .padding(.top,25)
            
           
            
            Button {
                
            } label: {
                //Mark: Login Button
            Text("Sign up")
                    .foregroundColor(.white)
                    .hAlign(.center)
                    .fillView(.black)
            }
            .padding(.top, 10)
        }
    }
}


#Preview {
    LoginView()
}

// Mark: View Extensions For UI Building
extension View {
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


