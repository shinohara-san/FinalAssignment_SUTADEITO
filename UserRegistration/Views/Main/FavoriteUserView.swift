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
    @State var favoriteUserInfo = EmptyUser.forLayout
    @State var isModal = false
    
    var body: some View {
        
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    Color.myWhite.edgesIgnoringSafeArea(.all)
                    List{
                        ForEach(self.shareData.filteredFavoriteUsers, id: \.id){ user in
                            VStack{
                                HStack{
                                    FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2)
                                        .clipShape(Circle()).shadow(radius: 2, x:2, y:5)
                                        .padding(.top, 8).padding(.leading)
                                   VStack(alignment: .leading,spacing: 5){
                                        HStack{
                                            if self.shareData.goodUser(user: user){
                                                Image(systemName: "hand.thumbsup.fill").foregroundColor(.yellow)
                                            }
                                            Text(user.name)
                                        }
                                         Text(user.age)
                                        
                                    }.foregroundColor(Color.myBlack).frame(width: geometry.size.width * 0.5, alignment: .leading)
                                    
                                }
                                if user.id == "" {
                                    Divider().hidden()
                                } else {
                                    Divider()
                                }
                            }
                            .listRowBackground(self.shareData.emptyUser(user: user) ? Color.myWhite : Color.myWhite2)
                                .onTapGesture {
                                    if user.id == "" {return}
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
                    .navigationBarItems(leading:
                        Button(action: {
                            self.shareData.switchFavAndLike = true
                        }, label: {
                            Image(systemName: "arrow.right.arrow.left").foregroundColor(Color.myWhite)
//                                .contextMenu{
//                                Button(action: {
//                                    self.shareData.switchFavAndLike = true
//                                }) {
//                                    Text("お気に入り")
//                                }
//
//                                Button(action: {
//                                    self.shareData.switchFavAndLike = false
//                                }) {
//                                    Text("いいね")
//                                    }
                                    
                            
                        }), trailing:
                        Button(action: {
                            self.shareData.myProfile = true
                        }, label: {
                            Image(systemName: "house.fill").foregroundColor(Color.myWhite)
                        })
                        )
                        .onAppear{
                            //                DispatchQueue.global().sync {
                            self.shareData.getAllFavoriteUsers()
                            //                }
                            
                    }

                } //navi
            }
            
        }
    } //body
} //view

//struct FavoriteUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteUserView()
//    }
//}
