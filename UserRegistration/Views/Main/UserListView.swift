//
//  UserListView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/02.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject var shareData: ShareData
    @State var userProfileOn = false
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "", fee: "", schedule: "", place: "")
    func emptyUser(user: User)->Bool{
        return user.id == ""
    }
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    @State var menuOn = false
    
    var body: some View {
        
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    List{
                        ForEach(self.shareData.filteredAllUsers, id: \.id){ user in
                           
//                            NavigationLink(destination: UserProfileView(user: user, matchUserProfile: false).environmentObject(self.shareData)){
                                UserRow(user: user, geometry: geometry)
                                
                                .onTapGesture {
                                    self.userInfo = user
                                    self.userProfileOn = true
                            }
                            .listRowBackground(self.emptyUser(user: user) ? Color.myWhite : Color.myWhite2)
                        } //foreach
                           
                    }
                    .onAppear { UITableView.appearance().separatorStyle = .none }
                    .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                    .onAppear{
                        self.shareData.getCurrentUser()
                        
                    }
                    if self.menuOn{
                        Color.black.opacity(0.3)
                        SutadeitoBox(menuOn: self.$menuOn)
                    }

                }//zstack
                    .navigationBarTitle("すたでいと", displayMode: .inline)
                    .navigationBarItems(leading:
                        Button(action: {
                            self.menuOn.toggle()
                        }, label: {
                            Image(systemName: "hand.thumbsup.fill")
                        })
                        
                        ,trailing:
                        Button(action: {
                            self.shareData.myProfile = true
                        }, label: {
                            Image(systemName: "house.fill").foregroundColor(Color.myWhite)
                        })
                )
                    .sheet(isPresented: self.$userProfileOn) {
                        UserProfileView(user: self.userInfo, matchUserProfile: false).environmentObject(self.shareData)
                } //sheet
            }//navi
        }//geo
    }//body
}

//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView()
//    }
//}
