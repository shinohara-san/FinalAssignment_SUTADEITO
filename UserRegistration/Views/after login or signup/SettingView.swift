//
//  SettingView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @State var editOn = false
    var datas: FirebaseData //firebaseの処理とか
    @EnvironmentObject var shareData: ShareData
    
    var body: some View {
        VStack {
            Group{
                if !editOn{
                    FirebaseImageView(imageURL: self.shareData.imageURL)
                    
                    HStack{
                        Text("名前")
                        Spacer()
                        Text(String(describing: self.shareData.currentUserData["name"] ?? ""))
                    }
                    HStack{
                        Text("年齢")
                        Spacer()
                        //                Text(String(describing: self.currentUser["age"] ?? ""))
                        Text(String(describing: self.shareData.currentUserData["age"] ?? ""))
                    }
                    HStack{
                        Text("勉強中")
                        Spacer()
                        Text(String(describing: self.shareData.currentUserData["subject"] ?? ""))
                    }
                    HStack{
                        Text("現住所")
                        Spacer()
                        Text(String(describing: self.shareData.currentUserData["hometown"] ?? ""))
                    }
                    HStack{
                        Text("趣味")
                        Spacer()
                        Text(String(describing: self.shareData.currentUserData["hobby"] ?? ""))
                    }
                    HStack{
                        Text("自己紹介")
                        Spacer()
                        Text(String(describing: self.shareData.currentUserData["introduction"] ?? ""))
                    }
                    HStack{
                        Text("性格")
                        Spacer()
                        Text(String(describing: self.shareData.currentUserData["personality"] ?? ""))
                    }
                    HStack{
                        Text("目的")
                        Spacer()
                        Text(String(describing: self.shareData.currentUserData["purpose"] ?? ""))
                    }
                    Section{
                        HStack{
                            Text("希望する勉強スタイル")
                            Spacer()
                            Text(String(describing: self.shareData.currentUserData["studystyle"] ?? ""))
                        }
                        HStack{
                            Text("職業")
                            Spacer()
                            Text(String(describing: self.shareData.currentUserData["work"] ?? ""))
                        }
                        
                        Button("ログアウト"){
                            
                            self.datas.logOut()
                            self.shareData.currentUserData = [String : Any]()
                            print("ログアウトしました")
                        }
                    }
                    
                } else {
                    ProfileEditView()
                }
            }//Group
            Button(action: {
                self.editOn.toggle()
            }) {
                Text(editOn ? "保存する" : "編集する")
            }
            
            
        }//VStack
            .onAppear{
                self.shareData.loadImageFromFirebase(path: "images/pictureOf_\(String(describing: self.shareData.currentUserData["email"] ?? ""))")
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
