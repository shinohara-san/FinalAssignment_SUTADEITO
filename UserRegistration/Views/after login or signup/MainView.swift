//
//  MainView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/16.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//
//shino@aaa.com
//　1234shino

import SwiftUI

struct MainView: View {
    
    var datas: FirebaseData
    
    @EnvironmentObject var shareData: ShareData
    
    @State var selection = 0 //必要?
    
    @State var userProfileOn = false
    @State var favoriteProfileOn = false
    
    @State var likeListOn = false
    @State var likeProfileOn = false
    
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
    @State var favoriteUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
    @State var likeUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
    @State var matchUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
    @State var messageOn = false
    
    @State var text = ""
    
    @ObservedObject var msgVM = MessageViewModel()
    
    var body: some View {
        
        TabView(selection: $selection) {
            ////ユーザー一覧のページ
            
            //            ListView(datas: self.datas)
            //                NavigationView{
            Group{
                if !userProfileOn{
                    ScrollView{
                        VStack{
                            ForEach(self.shareData.allUsers){ user in
                                
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
                            } //foreach
                                .buttonStyle(PlainButtonStyle())
                            
                        }//Vstack
                            
                            
                            .onAppear{
                                DispatchQueue.global().sync {
                                    self.shareData.getCurrentUser() //ログイン中のユーザー情報を取得し、そのあと全表示ユーザー情報取得
                                    print("リストビュー")
                                }
                        }
                        //                        .onDisappear(){
                        //                            self.userProfileOn = false
                        //                        }
                        
                    }//Scrollview
                } else {
                    VStack{
                        UserProfileView(user: userInfo)
                        Button("戻る"){
                            self.userProfileOn = false
                        }
                    }
                    
                }
                
            }//Profile
                
                .navigationBarTitle("")
                .navigationBarHidden(false)
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                    }
            }.tag(1)
            
            ////                    検索ページ
            SearchView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                    }
            }.tag(2)
            
            
            ////                    お気に入りユーザーのページ
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
                                self.shareData.favoriteUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")]
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
                            self.shareData.likeUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")]
                            self.likeProfileOn = false //favorite viewを去るときにmain viewも元の一覧表示に戻してあげる処理
                        }
                        
                    } //scroll
                    
                } //いいねとじ
                
                
            } //Group全体とじ
                
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                    }
            }
            .tag(3)
            
            
            
            ////                   マッチングページ
            Group{
                
                if !messageOn{
                    
                    VStack{
                        Text("マッチ一覧")
                        List(self.shareData.matchUserArray){ user in
                            HStack{
                                Text(user.name)
                                Text(user.age)
                            }.onTapGesture {
                                self.messageOn = true
                                self.matchUserInfo = user
                            }
                        }
                    }

                } else {
                    MessageView(matchUserInfo: self.matchUserInfo, messageOn: $messageOn)                    
                }
            }.onAppear{
                self.shareData.getAllMatchUser()
            }.onDisappear{
                self.shareData.matchUserArray = [User]()
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .tabItem {
                    VStack {
                        Image(systemName: "suit.heart")
                    }
            }.tag(4)
            
            
            
            
            ////                    自分のプロフィールページ
            SettingView(datas: self.datas)  //environmentに書き換えたい
                .tabItem {
                    VStack {
                        Image(systemName: "ellipsis")
                    }
            }.tag(5)
            
        } //tabView
            .onAppear{
                print("メインビュー")
        }
            
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}

