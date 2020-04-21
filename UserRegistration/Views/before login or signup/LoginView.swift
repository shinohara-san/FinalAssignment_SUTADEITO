//
//  LoginView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/16.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//shino@aaa.com
//　1234shino

import SwiftUI
import FirebaseFirestore

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @ObservedObject private var datas = firebaseData
    @EnvironmentObject var shareData: ShareData
    
    func getUser() {
        datas.listen()
    }
    
    var body: some View {
            
            Group {
            if datas.session != nil {
                
                MainView(datas: self.datas)
                .navigationBarBackButtonHidden(true)
                .onAppear(perform: getUser)
//                , userData: self.datas.session
                
            } else {
                VStack{
                    TextField("email", text: $email)
                        .disableAutocorrection(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                        .keyboardType(.emailAddress)
                    SecureField("password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle()).padding().keyboardType(.emailAddress)
                    
                    Button(action: {
                        if self.email == "" || self.password == ""{
                            return
                        }
                        self.datas.logIn(email: self.email, password: self.password) { (res, err) in
                            if err != nil {
                                print("Error: ログイン")
                            } else {
                                self.email = ""
                                self.password = ""
                            }
                        }
                    }) {
                        Text("ログイン")
                    }.padding(.bottom)
                }.onAppear(perform: getUser)
            
        }
      }
            

    }
  }
    
       
    

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
