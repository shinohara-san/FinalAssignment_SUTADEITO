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
                    VStack{
                        List(self.shareData.matchUserArray){ user in
                            //写真タップでプロフィール表示
                            NavigationLink(destination: MessageView(user, user.matchRoomId)){
                                HStack{
                                    FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.15)
                                        .clipShape(Circle())
                                    Text(user.name)
                                    Text(user.age)
                                }
                                
                            }
                            
                        }
                    }
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
