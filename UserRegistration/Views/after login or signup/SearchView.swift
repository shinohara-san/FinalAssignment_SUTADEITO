//
//  SearchView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var shareData: ShareData
    @State var hometown = ""
    @State var purpose = ""
    @State var subject = ""
    
    @State var userProfileOn = false
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")
    
    func emptifyTextField(){
        self.hometown = ""
        self.purpose = ""
        self.subject = ""
    }
    
    var body: some View {
        GeometryReader{ geo in
        ZStack{
            self.shareData.white.edgesIgnoringSafeArea(.all)
        VStack{
            
            Group{
                if !self.userProfileOn{
                    Text("条件をひとつ入れてください")
                    VStack{
                        HStack{
                            TextField("current city", text: self.$hometown).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                            
                            Button(action: {
                                self.shareData.searchUser(key: "hometown", value: self.hometown)
                                self.emptifyTextField()
                            }) {
                                Image(systemName: "magnifyingglass")
                            }
                            .padding(.trailing)
                        }
                        HStack{
                            TextField("purpose", text: self.$purpose).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                            
                            Button(action: {
                                self.shareData.searchUser(key: "purpose", value: self.purpose)
                                self.emptifyTextField()
                            }) {
                                Image(systemName: "magnifyingglass")
                            }
                            .padding(.trailing)
                        }
                        HStack{
                            TextField("subject", text: self.$subject).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                            
                            Button(action: {
                                self.shareData.searchUser(key: "subject", value: self.subject)
                                self.emptifyTextField()
                            }) {
                                Image(systemName: "magnifyingglass")
                            }
                            .padding(.trailing)
                        }
                    }// vstack
                    Divider()
                    
                    //ユーザーリスト
                    
                    ScrollView{
                        VStack{
                            ForEach(self.shareData.searchedUsers){ user in
                                
                                VStack{
                                    FirebaseImageView(imageURL: user.photoURL)
                                    HStack{
                                        Text("\(user.gender)") //テスト
                                        Text(user.age)
                                        Text(user.hometown)
                                    }
                                    Text(user.introduction)
                                    //
                                }
                                .onTapGesture {
                                    self.userInfo = user
                                    self.userProfileOn = true
                                    
                                }
                                
                                
                                
                                
                            } //foreach
                                .buttonStyle(PlainButtonStyle())
                            
                        }
                    } //scroll
                    
                } // if
                else {
                    VStack{
                        UserProfileView(user: self.userInfo)
                        Button("戻る"){
                            self.userProfileOn = false
                        }
                    }
                }
            } //group
            }
        }
        } //vstack
            
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onDisappear{
                self.userProfileOn = false
                self.shareData.searchedUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")]
        }
        
    } //body
    
} //searchView

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
