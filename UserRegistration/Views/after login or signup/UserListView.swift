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
                    ScrollView(showsIndicators: false){
                        VStack{
                            ForEach(self.shareData.allUsers){ user in
                                
                                VStack{
                                    FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2)
                                        .clipShape(Circle())
                                        .padding(.top, 8)
                                    HStack{
                                        Text(user.age)
                                        Text(user.hometown)
                                    }
                                    Text(user.introduction)
                                }
                                .onTapGesture {
                                    self.userInfo = user
                                    self.userProfileOn = true
                                }
                                
                            } //foreach
                            
                        }//Vstack
                            
                            
                            .onAppear{
                                DispatchQueue.global().sync {
                                    self.shareData.getCurrentUser()
                                    
                                }
                        }
                        
                    }//scroll
                }.navigationBarTitle("ユーザー", displayMode: .inline)
                    .sheet(isPresented: self.$userProfileOn) {
                        UserProfileView(user: self.userInfo, matchUserProfile: false).environmentObject(self.shareData)
                }
                
            }
        }//Profile
        
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
