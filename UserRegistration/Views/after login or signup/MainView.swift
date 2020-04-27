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
    
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")

//    @State var matchUserInfo = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
    @State var messageOn = false
    @State var userProfileOn = false
    @State var text = ""
    
    @ObservedObject var msgVM = MessageViewModel(shareData: ShareData.init())
    
    var body: some View {
        
        TabView {
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
                                    
//                                } //追加
                                

                            } //foreach
                                .buttonStyle(PlainButtonStyle())
                            
                        }//Vstack
                            
                            
                            .onAppear{
                                DispatchQueue.global().sync {
//                                    ispatchQueue.global().sync {
                                    self.shareData.getCurrentUser()
                                    //ログイン中のユーザー情報を取得し、そのあと全表示ユーザー情報取得
//                                    print(self.shareData.allUsers)
//                                    print(self.shareData.MatchUsers)
                                }
//                                DispatchQueue.global().sync {
//                                    print("フィルター前: \(self.shareData.allUsers)")
//                                    print(self.shareData.MatchUsers)
//                                    for user in self.shareData.allUsers{
//                                        for match in self.shareData.MatchUsers{
//                                            if user == match {
//                                                self.shareData.allUsers = self.shareData.allUsers.filter{ !self.shareData.MatchUsers.contains($0)}
//                                                print("フィルター後: \(self.shareData.allUsers)")
//                                            }
//                                        }
//                                    }
//                                }
                                
                                
                        }
                        .onDisappear(){
//                            self.shareData.matchUserId = [String]()
                        }
                        
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
            
            ///お気に入りいいね一覧ページ
            
            FavoriteAndLikeUserView(userProfileOn: $userProfileOn)
                
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                    }
            }
            .tag(3)
            
            
            
            ////                   マッチングページ
            Group{
                
                VStack{
                    Text("マッチ一覧")
                    List(self.shareData.matchUserArray){ user in
                        NavigationLink(destination: MessageView(matchUserInfo: user)){
                            HStack{
                                Text(user.name)
                                Text(user.age)
                            }

                        }
                        
                    }
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
            SettingView(datas: self.datas)
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

