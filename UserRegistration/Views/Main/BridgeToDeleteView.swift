//
//  BridgeToDeleteView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/08.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct BridgeToDeleteView: View {
     @State var email = ""
        @State var password = ""
        @ObservedObject private var datas = firebaseData
        @EnvironmentObject var shareData: ShareData
    
//        @Environment(\.presentationMode) var presentation
        
        
        func getUser() {
            datas.listen()
        }
        
        var body: some View {
            
            Group {
                if datas.session != nil {

                    DeleteAccountView(self.datas)
                        .navigationBarBackButtonHidden(true)
                        .onAppear(perform: getUser)

                } else {
//
                    NavigationView {
                        GeometryReader{ geometry in
                            ZStack{
                            Color.gray.edgesIgnoringSafeArea(.all)
                            
                            Image("coffeeheart").resizable().edgesIgnoringSafeArea(.all)
                            Color.black.edgesIgnoringSafeArea(.all).opacity(0.3)
                            VStack{
                                Spacer()
                                TextField("email", text: self.$email)
                                    .disableAutocorrection(true)
                                    .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                    
                                    .keyboardType(.emailAddress)
                                    .padding(.bottom)
                                SecureField("password", text: self.$password)
                                    .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                    
                                    .keyboardType(.emailAddress)
                                    .padding(.bottom)
                                
                                Button(action: {
                                    if self.email == "" || self.password == ""{
                                        return
                                    }
                                    self.datas.logIn(email: self.email.trimmingCharacters(in: .whitespacesAndNewlines), password: self.password.trimmingCharacters(in: .whitespacesAndNewlines)) { (res, err) in
                                        if err != nil {
                                            print("Error: ログイン")
                                            
                                        } else {
                                            self.email = ""
                                            self.password = ""
                                        }
                                    }
                                }) {
                                    Text("ログイン").foregroundColor(self.shareData.white)
                                        .padding()
                                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05)
                                    .background(self.shareData.pink).cornerRadius(10)
                                    .shadow(radius: 2, y:2)
                                }.padding(.bottom, 50)
                                  
                                Spacer()
                                
                            }
//                            .onAppear(perform: self.getUser)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                                .padding(.top, 80)
                            
                            }
                        }
                        }
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    
                }

            }

            }

        }
        

struct BridgeToDeleteView_Previews: PreviewProvider {
    static var previews: some View {
        BridgeToDeleteView()
    }
}
