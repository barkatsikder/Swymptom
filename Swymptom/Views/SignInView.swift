//
//  SignInView.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/24/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//

import SwiftUI

import Firebase
import GoogleSignIn



//see if sign up is different from sign in
struct SignInView: View {
    
  @Environment(\.window) var window: UIWindow?
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //@EnvironmentObject var googleDelegate: GoogleDelegate
  
  //@State var signInHandler: SignInWithGoogleCoordinator?
  
  var body: some View {
    VStack {
      Image(systemName: "bandage")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding(.horizontal, 100)
        .padding(.top, 100)
        .padding(.bottom, 50)
      
      
      HStack {
        Text("Welcome to")
          .font(.title)
        
        Text("Swymptoms")
          .font(.title)
          .fontWeight(.semibold)
      }
      
      Text("Create an account to save your COVID symptoms and access them anywhere. It's free. \n Forever.")
        .font(.headline)
        .fontWeight(.medium)
        .multilineTextAlignment(.center)
        .padding(.top, 20)
      
      Spacer()
      
      SignInWithGoogleButton()
        .frame(width: 280, height: 45)
//        .onTapGesture {
//          self.signInWithGoogleButtonTapped()
//      }
      
      // other buttons will go here
      
      Divider()
        .padding(.horizontal, 15.0)
        .padding(.top, 20.0)
        .padding(.bottom, 15.0)

      
      Text("By using Swymptoms you agree to our Terms of Use and Service Policy")
        .multilineTextAlignment(.center)
    }
  }
    
}




// MARK: - SignInWithGoogleButtonView
struct SignInWithGoogleButton: View {
  //@Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var body: some View {
    
    //may not work because syntax for apple button. instead:
    SignInWithGoogleButtonInternal().frame(width: 120, height: 50)
//    Group {
//      if colorScheme == .light {
//        SignInWithGoogleButtonInternal(colorScheme: .light)
//      }
//      else {
//        SignInWithGoogleButtonInternal(colorScheme: .dark)
//      }
//    }
    
  }
}

//basically the MV
fileprivate struct SignInWithGoogleButtonInternal: UIViewRepresentable {
  //var colorScheme: ColorScheme
  
  func makeUIView(context: UIViewRepresentableContext<SignInWithGoogleButtonInternal>) -> GIDSignInButton {
      
      let button = GIDSignInButton()
      button.colorScheme = .dark
      GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
      return button
    }
    
//        func updateUIView(_ uiView: UIViewType, context: Context) {}
//    }
    
  func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<SignInWithGoogleButtonInternal>) {

  }

}

