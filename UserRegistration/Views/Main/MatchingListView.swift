//
//  MatchingListView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/02.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct MatchingListView: View {
    @EnvironmentObject var shareData: ShareData
    
    var body: some View {
        //       Group{
        GeometryReader{ geometry in
            ZStack{
                self.shareData.pink.edgesIgnoringSafeArea(.all)
                NavigationView{
                    
                    List{
                        ForEach(self.shareData.matchUserArray){ user in
                            //写真タップでプロフィール表示
                            NavigationLink(destination: MessageView(user, user.matchRoomId)){
                                VStack{
                                HStack{
                                    FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.1)
                                        .clipShape(Circle()).shadow(radius: 2, x:2, y:2)
                                    Text(user.name)
                                    Text(user.age)
                                }
//                                    Divider() pathで線引く
                                }
                            }
                        }.listRowBackground(self.shareData.white) //foreachに
                    }
                    .onAppear { UITableView.appearance().separatorStyle = .none }
                    .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                    .navigationBarTitle(Text("マッチ一覧"), displayMode: .inline)
                }
            }
        }.onAppear{
            self.shareData.getAllMatchUser()
            print("マッチ一覧: \(self.shareData.matchUserArray)")
            
            
        }.onDisappear{
            self.shareData.matchUserArray = [User]()
        }
        //       }
    }
}

struct MatchingListView_Previews: PreviewProvider {
    static var previews: some View {
        MatchingListView()
    }
}

//ai@aaa.com
//1234ai
