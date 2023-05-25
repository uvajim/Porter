//
//  LoginView.swift
//  Porter
//
//  Created by Jinming Liang on 3/31/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State var email = ""
    @State private var password = ""
    @Binding var showLogIn: Bool
    
    
    var body: some View {
        VStack{
            TextField("E-Mail", text: $email).keyboardType(.emailAddress)
            SecureField("Password", text: $password)
            Button(action: {validateUser(email: email, password: password)}, label: {Text("Sign Up")})
        }
    }
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
            if let error = error{
                print(error)
                print(error.localizedDescription)
                return
            }
            else{
                print("Successfully created user")
            }
        }
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func validateUser(email: String, password:String){
        try signIn(email: email, password: password)
        try createUser(email: email, password: password)
        showLogIn = false
        }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Placeholder")
    }
}
