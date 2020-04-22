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
    
    func getUser() {
        datas.listen()
    }
    
    var body: some View {
        
        Group {
        if datas.session != nil {
        VStack {
            Group{
                if !editOn{
                    FirebaseImageView(imageURL: self.shareData.imageURL)
                    ProfileUserDetailView(
                        name: String(describing: self.shareData.currentUserData["name"] ?? ""),
                        age: String(describing: self.shareData.currentUserData["age"] ?? ""),
                        gender: String(describing: self.shareData.currentUserData["gender"] ?? ""),
                        hometown: String(describing: self.shareData.currentUserData["hometown"] ?? ""),
                        subject: String(describing: self.shareData.currentUserData["subject"] ?? ""),
                        introduction: String(describing: self.shareData.currentUserData["introduction"] ?? ""),
                        studystyle: String(describing: self.shareData.currentUserData["studystyle"] ?? ""),
                        hobby: String(describing: self.shareData.currentUserData["hobby"] ?? ""),
                        personality: String(describing: self.shareData.currentUserData["personality"] ?? ""),
                        work: String(describing: self.shareData.currentUserData["work"] ?? ""),
                        purpose: String(describing: self.shareData.currentUserData["purpose"] ?? ""))
                    
                        Button("ログアウト"){
                            
                            self.datas.logOut()
                            self.shareData.currentUserData = [String : Any]()
                            print("ログアウトしました")
                        } //ProfileUserDetailView
                    
                    
                } else {
                    ProfileEditView()
                }
            }//Group
            
            Button(action: {
                self.editOn.toggle()
            }) {
                Text(editOn ? "保存する" : "編集する")
            }
            
            Button(action: {
                //アラート出したいなー
                self.shareData.deleteAccount() //Auth削除
                self.shareData.deleteUserData() //Firestore削除
                
                self.shareData.currentUserData = [String : Any]()
                self.datas.listen()
                //Storageにおいてある写真の削除も忘れずに
                
            }){
                Text("退会する")
            }
            
            
        }//VStack
            .onAppear{
             self.shareData.loadImageFromFirebase(path: "images/pictureOf_\(String(describing: self.shareData.currentUserData["email"] ?? ""))")
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        } else {
            TopPageView()
            }
            
        }
           
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
