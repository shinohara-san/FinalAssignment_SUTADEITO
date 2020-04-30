//
//  FavoriteAndLikeUserView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/26.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct FavoriteAndLikeUserView: View {
    @EnvironmentObject var shareData: ShareData
    @Binding var userProfileOn:Bool //メインビューの
    @State var favoriteProfileOn = false
    
    @State var likeListOn = false
    @State var likeProfileOn = false
    
    @State var favoriteUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")
    
    @State var likeUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")
    
    var body: some View {
        Group{
            
            if !self.likeListOn{
                if !favoriteProfileOn{
                    ScrollView{
                        VStack{
                            Button("いいね一覧へ"){
                                self.likeListOn = true
                            }
                            Text("お気に入りユーザー")
                            ForEach(self.shareData.favoriteUsers){ user in
                                VStack{
                                    FirebaseImageView(imageURL: user.photoURL)
                                    Text(user.name)
                                    Text(user.gender)
                                    Text(user.age)
                                }
                                .onTapGesture {
                                    self.favoriteUserInfo = user
                                    self.favoriteProfileOn = true
                                }
                            }
                        }
                        .navigationBarTitle("お気に入りユーザー一覧")
                        .navigationBarHidden(true)
                        .onAppear{
                            //                DispatchQueue.global().sync {
                            self.shareData.getAllFavoriteUsers()
                            //                }
                        }
                        .onDisappear{
                            self.shareData.favoriteUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")]
                            self.userProfileOn = false //favorite viewを去るときにmain viewも元の一覧表示に戻してあげる処理
                        }
                        
                    } //scroll
                    
                } else {
                    
                    VStack{
                        UserProfileView(user: favoriteUserInfo)
                        Button("戻る"){
                            self.favoriteProfileOn = false
                        }
                    }.onDisappear{
                        self.favoriteProfileOn = false
                    }
                    
                } //お気に入り一覧閉じ
            } //if !self.likeListOn　いいね一覧表示off閉じ
            else
            { ///いいね一覧スタート
                
                ScrollView{
                    VStack{
                        Button("お気に入り一覧へ"){
                            self.likeListOn = false
                        }
                        Text("いいねを送ったユーザー")
                        if !self.likeProfileOn{
                            ForEach(self.shareData.likeUsers){ user in
                                VStack{
                                    FirebaseImageView(imageURL: user.photoURL)
                                    Text(user.name)
                                    Text(user.gender)
                                    Text(user.age)
                                }
                                .onTapGesture {
                                    self.likeUserInfo = user
                                    self.likeProfileOn = true
                                }
                            }
                        } else {
                            UserProfileView(user: likeUserInfo)
                                .onDisappear{
                                    
                                    self.shareData.getAllLikeUsers()
                                    
                            }
                            Button("戻る"){
                                self.likeProfileOn = false
                            }
                        }
                        
                    }
                    .navigationBarTitle("いいねしたユーザー")
                    .navigationBarHidden(true)
                    .onAppear{
                        //                DispatchQueue.global().sync {
                        self.shareData.getAllLikeUsers()
                        //                }
                    }
                    .onDisappear{
                        self.shareData.likeUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")]
                        self.likeProfileOn = false //favorite viewを去るときにmain viewも元の一覧表示に戻してあげる処理
                    }
                    
                } //scroll
                
            } //いいねとじ
            
            
        } //Group全体とじ
    }
}

//struct FavoriteAndLikeUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteAndLikeUserView()
//    }
//}
