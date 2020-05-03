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
    
    //@State var selection = 0 //必要?
    
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "")
    
    @State var messageOn = false
    @State var userProfileOn = false
    @State var text = ""
    
    @State var matchid = ""
    
    init(_ datas: FirebaseData) {
        self.datas = datas
        UITabBar.appearance().barTintColor = UIColor(red: 135/255, green: 206/255, blue: 250/255, alpha: 1)
    }
    
    
    var body: some View {
        
//        GeometryReader{ geometry in
            TabView {
                
                ////ユーザー一覧のページ
                UserListView().environmentObject(self.shareData)
                
                    .tabItem {
                        VStack {
                            Image(systemName: "book.fill")
                        }
                }.tag(2)
                
                ////                    検索ページ
                SearchView()
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                        }
                }.tag(1)
                
                ///お気に入りいいね一覧ページ
//                Group{
//                    if self.shareData.switchFavAndLike{
//                        LikeUserView().environmentObject(self.shareData)
//                    } else {
                        FavoriteUserView().environmentObject(self.shareData)
//                    }
//                }
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                    }
                }
                .tag(3)
                
                
                
                ////                   マッチングページ
                MatchingListView().environmentObject(self.shareData)
                    .tabItem {
                        VStack {
                            Image(systemName: "suit.heart.fill")
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
                .accentColor(self.shareData.pink)

    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}

