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
    
    @State var isModal = false
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    self.shareData.white.edgesIgnoringSafeArea(.all)
                    List{
                        ForEach(self.shareData.filteredSearchedUsers){ user in
                            VStack{
                            SmallUserRow(user: user, geometry: geometry)
                                                               .onTapGesture {
                                    if user.id == "" {return}
                                    self.userInfo = user
                                    self.isModal = true
                            }
                                if user.id == "" {
                                    Divider().hidden()
                                } else {
                                    Divider()
                                }
                            }
                        }.listRowBackground(self.shareData.white)

                        
                    } //list
                        
                        .onAppear { UITableView.appearance().separatorStyle = .none }
                        .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                        .sheet(isPresented: self.$isModal) {
                            UserProfileView(user: self.userInfo, matchUserProfile: false).environmentObject(self.shareData)
                    }
                    .navigationBarTitle(Text("ユーザー検索"), displayMode: .inline)
                    .navigationBarItems(leading:
                        Button(action: {
                            self.shareData.searchBoxOn.toggle()
                        }, label: {
                            Image(systemName: "magnifyingglass").foregroundColor(self.shareData.white)
                        }),
                        trailing:
                        Button(action: {
                            self.shareData.myProfile = true
                        }, label: {
                            Image(systemName: "house.fill").foregroundColor(self.shareData.white)
                        })
                    )
                        .onAppear{
                            self.shareData.filteredSearchedUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")]
                    }
                    .onDisappear{
                        //                self.userProfileOn = false
                        self.shareData.filteredSearchedUsers = [User]()
                        self.hometown = ""
                        self.purpose = ""
                        self.subject = ""
                    }
                    
                    if self.shareData.searchBoxOn{
                        Color.black.edgesIgnoringSafeArea(.all).opacity(0.3)
                        ScrollView{
                            SearchBoxView(hometown: self.$hometown, purpose: self.$purpose, subject: self.$subject).background(self.shareData.white).cornerRadius(10).frame(width : geometry.size.width * 0.8, height: geometry.size.height * 0.5).offset(y: 25).animation(.default)
                        }
                    }
                    
                } //navi
            }
            
        }
       
    }
    
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
