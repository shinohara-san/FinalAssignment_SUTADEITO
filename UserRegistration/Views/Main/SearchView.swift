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
//                        searchRow(placeHolder: "current city", geometry: geo, text: self.hometown, value: self.hometown, otherKey1: self.purpose, otherKey2: self.subject, systemName: "magnifyingglass.circle.fill")
        
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
                        
                        List{
                            ForEach(self.shareData.searchedUsers){ user in
                                SmallUserRow(user: user, geometry: geo)
                                    .onTapGesture {
                                        self.userInfo = user
                                        self.userProfileOn = true
                                        
                                }
                            } //foreach
                                .listRowBackground(self.shareData.white)
                        } //scroll
                            .onAppear { UITableView.appearance().separatorStyle = .none }
                            .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                        
                    }//vstac
                        
                }//zstac
                 .navigationBarTitle(Text("ユーザー検索"), displayMode: .inline)
                .navigationBarItems(trailing:
                Button(action: {
                    self.shareData.myProfile = true
                }, label: {
                    Image(systemName: "house.fill").foregroundColor(self.shareData.white)
                })
                )
                .sheet(isPresented: self.$userProfileOn) {
                        UserProfileView(user: self.userInfo, matchUserProfile: false).environmentObject(self.shareData)
                }
            } //navi
            
        } //geo
            .onDisappear{
                //                self.userProfileOn = false
                self.shareData.searchedUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")]
                self.hometown = ""
                self.purpose = ""
                self.subject = ""
        }
    } //body
    
    
} //view
//            山梨県

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

struct searchRow: View{
    @EnvironmentObject var shareData: ShareData
    let placeHolder:String
    let geometry:GeometryProxy
    @State var text:String
    let value : String
    @State var otherKey1 : String
    @State var otherKey2 : String
    var systemName : String
    
    var body : some View{
        HStack{
            TextField(placeHolder, text: $text).textFieldStyle(CustomTextFieldStyle(geometry: geometry)).padding()
        
        Button(action: {
            self.shareData.searchUser(key: self.placeHolder, value: self.value)
            self.otherKey1 = ""
            self.otherKey2 = ""
        }) {
            Image(systemName: systemName).resizable().frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.05).accentColor(.purple)
        }
        .padding(.trailing)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
