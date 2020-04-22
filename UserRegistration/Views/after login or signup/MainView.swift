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
    
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
    @State var favoriteUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
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
                if !favoriteProfileOn{
                    ScrollView{
                        VStack{
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
                        .navigationBarTitle("")
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
                    
                }
            } //Group
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                    }
            }
            .tag(3)
            
            
            
            ////                   マッチングページ
            MatchView()
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
        }.onAppear{
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

