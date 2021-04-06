//
//  LoginView.swift
//  SplitwiseLab
//
//  Created by Felipe Ramirez Vargas on 30/3/21.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @State var userName = ""
    @State var password = ""
    @AppStorage("stored_User") var user = "jfelipe221095@gmail.com"
    @AppStorage("stored_Pass") var pass = "123456"
    @AppStorage("status") var logged = false
    var body: some View {
        VStack{
            Spacer(minLength: 0)
            Image(systemName: "person.icloud")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 35)
                .padding(.vertical)
            HStack{
                VStack(alignment: .leading, spacing: 12, content: {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("Please sign in to continue")
                        .foregroundColor(Color.black.opacity(0.5))
                })
                Spacer(minLength: 0)
            }
            .padding(.leading, 15)
            HStack{
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.black)
                    .frame(width: 35)
                TextField("EMAIL", text: $userName)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(userName == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            
            HStack{
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.black)
                    .frame(width: 35)
                SecureField("PASSWORD", text: $password)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(userName == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.top)
            
            HStack(spacing: 15){
                Button(action: authenticateUserPassword, label: {
                    Text("LOGIN")
                        .fontWeight(.heavy)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                })
                .opacity(userName != "" && password != "" ? 1 : 0.5)
                .disabled(userName != "" && password != "" ? false : true)
                if getBiometricStatus(){
                    Button(
                        action: authenticateUser,
                        label: {
                            Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    )
                }
            }
        }
    }
    
    func authenticateUserPassword(){
        if userName == user && password == pass {
            withAnimation(.easeOut){logged = true}
        }else{
            print("User Password Does not match")
        }
    }
    
    func getBiometricStatus()->Bool{
        let scanner = LAContext()
        //Biometry is available on the device
        if userName == user && scanner.canEvaluatePolicy(.deviceOwnerAuthentication, error: .none){
            return true
        }
        return false
    }
    
    func authenticateUser(){
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock \(userName)"){(status, error) in
            if error != nil{
                print("Error")
                print(error!.localizedDescription)
                return
            }
            withAnimation(.easeOut){logged = true}
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
