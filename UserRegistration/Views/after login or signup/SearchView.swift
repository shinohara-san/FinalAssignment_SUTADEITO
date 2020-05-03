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
    
    var body: some View {
        GeometryReader{ geo in
            //            NavigationView{
//            東京都
            //                    VStack{
            
//            Group{
//                if !self.userProfileOn{
                    NavigationView{
                        ZStack{
                            self.shareData.white.edgesIgnoringSafeArea(.all)
                            
                            VStack{
                                Text("条件をひとつ入れてください")
                                    .foregroundColor(Color(red: 42/255, green: 34/255, blue: 56/255))
                                    .padding(.top)
                                
                                HStack{
                                    TextField("current city", text: self.$hometown).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                                    
                                    Button(action: {
                                        self.shareData.searchUser(key: "hometown", value: self.hometown)
                                        self.purpose = ""
                                        self.subject = ""
                                    }) {
                                        Image(systemName: "magnifyingglass.circle.fill").resizable().frame(width: geo.size.width * 0.1, height: geo.size.height * 0.05).accentColor(.yellow)
                                    }
                                    .padding(.trailing)
                                }
                                HStack{
                                    TextField("purpose", text: self.$purpose).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                                    
                                    Button(action: {
                                        self.shareData.searchUser(key: "purpose", value: self.purpose)
                                        self.hometown = ""
                                        self.subject = ""
                                    }) {
                                        Image(systemName: "magnifyingglass.circle.fill").resizable().frame(width: geo.size.width * 0.1, height: geo.size.height * 0.05).accentColor(.green)
                                    }
                                    .padding(.trailing)
                                }
                                HStack{
                                    TextField("subject", text: self.$subject).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                                    
                                    Button(action: {
                                        self.shareData.searchUser(key: "subject", value: self.subject)
                                        self.hometown = ""
                                        self.purpose = ""
                                    }) {
                                        Image(systemName: "magnifyingglass.circle.fill").resizable().frame(width: geo.size.width * 0.1, height: geo.size.height * 0.05).accentColor(.purple)
                                    }
                                    .padding(.trailing)
                                }
                                
                                
                                
                                Divider().frame(width: geo.size.width * 0.8)
                                
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
                                            
                                        } //foreachshino@aaa.com
                                        
                                    }
                                } //scroll
                                
                            }//vstac
                                .sheet(isPresented: self.$userProfileOn) {
                                    UserProfileView(user: self.userInfo, matchUserProfile: false).environmentObject(self.shareData)
                            }
                        }//zstac
                      .navigationBarTitle(Text("ユーザー検索"), displayMode: .inline)
                    } //navi

                } //geo
        .onDisappear{
                self.userProfileOn = false
                self.shareData.searchedUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")]
        }
            } //body

            
        } //view
            
            
//            .onDisappear{
//                self.userProfileOn = false
//                self.shareData.searchedUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")]
//        }
        
     //body
    
 //searchView

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
