//
//  SettingView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    var datas: FirebaseData
    @EnvironmentObject var shareData: ShareData
    
    
    
    var body: some View {
        
        Group {
        if datas.session != nil {
            GeometryReader{ geo in
            VStack {
            Group{
                if !self.shareData.editOn{
                    
                    ZStack{
                        self.shareData.white.edgesIgnoringSafeArea(.all)
                        
                        VStack{
                    FirebaseImageView(imageURL: self.shareData.imageURL).frame(width: geo.size.width * 0.9, height: geo.size.height * 0.4).cornerRadius(7)
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
                        purpose: String(describing: self.shareData.currentUserData["purpose"] ?? "")).frame(width: geo.size.width * 0.9)
                    
                        Button(action: {
                            self.shareData.editOn = true
                        }) {
                            Text("編集する")
                        }
                    
                        Button("ログアウト"){
                            
                            self.datas.logOut()
                            self.shareData.currentUserData = [String : Any]()
                            print("ログアウトしました")
                        } //ProfileUserDetailView
                    }
                    }
                } else {
                    ProfileEditView(datas: self.datas)
                }
            }//Group
            
            
            
            
            
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
