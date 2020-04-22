//
//  PictureUploadView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/18.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct PictureUploadView: View {
    @State var email:String
    var password:String
    var name:String
    var age:String
    var gender:String
    var hometown:String
    var subject:String
    var introduction:String
    var studystyle:String
    var hobby:String
    var personality:String
    var job:String
    var purpose:String
    
    @State var imageURL = ""
    @State var shown = false
    @ObservedObject private var datas = firebaseData
    @EnvironmentObject var shareData: ShareData
    
    var body: some View {
        
        Group {
                    if datas.session != nil {
                        MainView(datas: self.datas)
                        .navigationBarBackButtonHidden(true)
//                        .navigationBarTitle("")
//                        .navigationBarHidden(true)
        //                , userData: self.datas.session
                        
                    } else {
        
        VStack{
            if self.imageURL != "" {
                FirebaseImageView(imageURL: self.imageURL)
            }
            Button(action: {
                self.shown.toggle()
            }) {
                Text("upload")
            }
            Button(action: {
                self.datas.createData(self.email, self.name, self.age, self.gender, self.hometown, self.subject, self.introduction, self.studystyle, self.hobby, self.personality, self.job, self.purpose, self.imageURL)
                
                //                    Authの処理
                self.datas.signUp(self.email, self.password) { (res, err) in
                    if err != nil{
                        print("Signup失敗...")
                    } else {
                        self.datas.listen()
                        print("Signup成功！")
                    }
                    
                }
            }) {
                Text("登録")
            }
        }
            .sheet(isPresented: $shown) {
                imagePicker(shown: self.$shown, imageURL: self.$imageURL, email:self.$email)
            }

        .animation(.spring())
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
}
}


//struct PictureUploadView_Previews: PreviewProvider {
//    static var previews: some View {
//        PictureUploadView()
//    }
//}
