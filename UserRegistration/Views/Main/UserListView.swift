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
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")
    

    
    var body: some View {
        
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    self.shareData.white.edgesIgnoringSafeArea(.all)
                    //                    ScrollView(showsIndicators: false){
                    
                    List{
                        ForEach(self.shareData.filteredAllUsers, id: \.id){ user in
                            //                            VStack{
                            UserRow(user: user, geometry: geometry)
                                .onTapGesture {
                                    self.userInfo = user
                                    self.userProfileOn = true
                            }
                        } //foreach
                            .listRowBackground(self.shareData.white)
                    }
                    .onAppear { UITableView.appearance().separatorStyle = .none }
                    .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                    .onAppear{
                            self.shareData.getCurrentUser()
                        
                    }
                   
                }
                    //
                    .navigationBarTitle("すたでいと", displayMode: .inline)
                    .navigationBarItems(trailing:
                        Button(action: {
                            self.shareData.myProfile = true
                        }, label: {
                            Image(systemName: "house.fill").foregroundColor(self.shareData.white)
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
