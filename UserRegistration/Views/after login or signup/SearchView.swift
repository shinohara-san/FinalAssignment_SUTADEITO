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
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
    func emptifyTextField(){
        self.hometown = ""
        self.purpose = ""
        self.subject = ""
    }
    
    var body: some View {
        VStack{
            
            Group{
                if !self.userProfileOn{
                    Text("条件を入れてください")
                    VStack{
                        HStack{
                            TextField("居住地", text: $hometown).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                            
                            Button("検索"){
                                self.shareData.searchUser(key: "hometown", value: self.hometown)
                                self.emptifyTextField()
                                
                            }.padding(.trailing)
                        }
                        HStack{
                            TextField("目的", text: $purpose).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                            Button("検索"){
                                self.shareData.searchUser(key: "purpose", value: self.purpose)
                                self.emptifyTextField()
                                
                            }.padding(.trailing)
                        }
                        HStack{
                            TextField("科目", text: $subject).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                            Button("検索"){
                                self.shareData.searchUser(key: "subject", value: self.subject)
                                self.emptifyTextField()
                                
                            }.padding(.trailing)
                        }
                    }// vstack
                    Divider()
                    
                    //ユーザーリスト
                    
                    ScrollView{
                        VStack{
                            ForEach(self.shareData.searchedUsers){ user in
                                NavigationLink(destination: UserProfileView(user: self.userInfo)){
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
                                }
                                
                                
                                
                            } //foreach
                                .buttonStyle(PlainButtonStyle())
                            
                        }
                    } //scroll
                    
                } // if
                //             else {
                //                    VStack{
                //                        UserProfileView(user: userInfo)
                //                        Button("戻る"){
                //                            self.userProfileOn = false
                //                        }
                //                    }
                //                }
            } //group
                .onDisappear{
                    self.shareData.searchedUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")]
                    self.userProfileOn = false
            }
            
        } //vstack
            
            .navigationBarTitle("")
            .navigationBarHidden(true)
        
    } //body
    
} //searchView

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
