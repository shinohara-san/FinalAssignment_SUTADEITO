//
//  FavoriteUserView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/02.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct FavoriteUserView: View {
    @EnvironmentObject var shareData: ShareData
    //    @State var favoriteProfileOn = false
    @State var favoriteUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")
    @State var isModal = false
    
    var body: some View {
        
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    self.shareData.white.edgesIgnoringSafeArea(.all)
                    List{
                        ForEach(self.shareData.favoriteUsers){ user in
                            VStack{
                                HStack{
                                    FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2)
                                        .clipShape(Circle()).shadow(radius: 2, x:2, y:2)
                                        .padding(.top, 8).padding(.leading)
                                    VStack(alignment: .leading,spacing: 5){
                                        
                                        Text(user.name).frame(width: geometry.size.width * 0.5, alignment: .leading)
                                        Text(user.age)
                                            .frame(width: geometry.size.width * 0.5, alignment: .leading)
                                    }
                                    
                                }
                            }.listRowBackground(self.shareData.white)
                                .onTapGesture {
                                    self.favoriteUserInfo = user
                                    self.isModal = true
                            }
                        }
                        
                    } //list
                        
                        .onAppear { UITableView.appearance().separatorStyle = .none }
                        .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                        .sheet(isPresented: self.$isModal) {
                            UserProfileView(user: self.favoriteUserInfo, matchUserProfile: false).environmentObject(self.shareData)
                    }
                    .navigationBarTitle(Text("お気に入りユーザー"), displayMode: .inline)
                    .navigationBarItems(trailing:
                        Button(action: {
                            self.shareData.switchFavAndLike = true
                        }, label: {
                            Image(systemName: "arrow.right.arrow.left").foregroundColor(self.shareData.white)
                        })
                    )
                        .onAppear{
                            //                DispatchQueue.global().sync {
                            self.shareData.getAllFavoriteUsers()
                            //                }
                            
                    }
                    .onDisappear{
                        self.shareData.favoriteUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")]
                        
                    }
                } //navi
            }
            
        }
    } //body
} //view

struct FavoriteUserView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteUserView()
    }
}
