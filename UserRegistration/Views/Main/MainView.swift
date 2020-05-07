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
import FirebaseFirestore

struct MainView: View {
    
    var datas: FirebaseData
    
    @EnvironmentObject var shareData: ShareData
    
    @State var selection = 0 //ないと表示が崩れる?
    
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")
    
    @State var messageOn = false
    @State var userProfileOn = false
    @State var text = ""
    
    @State var matchid = ""
    
//    @State private var xOffset = CGFloat.zero
//    @State private var defaultOffset = CGFloat.zero
    
    init(_ datas: FirebaseData) {
        self.datas = datas
        UITabBar.appearance().barTintColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
    }
    
    
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack{
            TabView(selection: self.$selection) {
//                HStack{
//                    MenuView().frame(width: geometry.size.width * 0.68)
                    ////ユーザー一覧のページ
                    UserListView().environmentObject(self.shareData).frame(width: geometry.size.width)
//                }
                    .tabItem {
                        VStack {
                            Image(systemName: "book.fill")
                        }
                }.tag(1)
                
                ////                    検索ページ
                SearchView().environmentObject(self.shareData)
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                        }
                }.tag(2)
                
                ///お気に入りいいね一覧ページ
                Group{
                    if self.shareData.switchFavAndLike{
                        LikeUserView().environmentObject(self.shareData)
                    } else {
                        FavoriteUserView().environmentObject(self.shareData)
                    }
                }
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                    }
                }
                .tag(3)
                
                
                
                LikeMeUserView().environmentObject(self.shareData)

                    .tabItem {
                        VStack {
                            Image(systemName: "suit.heart")
                        }
                }.tag(4)
                
                
                
                ////                   マッチングページ
                MatchingListView().environmentObject(self.shareData)
                    .tabItem {
                        VStack {
                            Image(systemName: "suit.heart.fill")
                        }
                }.tag(5)
                
                
                
            } //tabView
                .accentColor(self.shareData.pink)
                .animation(nil)
                
                if self.shareData.myProfile{
                    SettingView(datas: self.datas).environmentObject(self.shareData)

                }
                
            }//ZStack

        }
        .navigationBarTitle("")
        .navigationBarHidden(true) //自分のプロフィール用
        .onAppear{
//                self.shareData.getCurrentUser()
                
                self.shareData.myProfile = false
                self.shareData.filteredMatchUserArray = [User]()//追記0507
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}

