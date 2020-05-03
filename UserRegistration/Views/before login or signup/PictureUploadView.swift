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
    
    @Environment(\.presentationMode) var presentation
    @Binding var pre: PresentationMode
    
//    @State var showingAlert = false
    @State var showingCompletion = false
    
    var allSectionsFilled: Bool {
        return !imageURL.isEmpty
    }
    
    var buttonColor: Color {
        return allSectionsFilled ? shareData.pink : Color(red: 220/255, green: 220/255, blue: 220/255)
    }
    
    var body: some View {
        //        Group {
        //            if self.datas.session != nil {
        //                MainView(datas: self.datas)
        //                    .navigationBarBackButtonHidden(true)
        //
        //            } else {
        GeometryReader{ geometry in
            ZStack{
                self.shareData.white.edgesIgnoringSafeArea(.all)
                
                VStack{
                    if self.imageURL != "" {
                        FirebaseImageView(imageURL: self.imageURL).frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.4).shadow(radius: 2, x: 2, y: 2).padding(.vertical).cornerRadius(10).animation(.spring())
                    }
                    Button(action: {
                        self.shown.toggle()
                    }) {
                        Text("写真を追加する").padding()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05).foregroundColor(self.shareData.white).background(self.shareData.brown).cornerRadius(10).shadow(radius: 2, y:2)
                    }.padding(.bottom)
                    
                    Button(action: {
                        
//                        if self.imageURL == ""  {
//                            self.showingAlert = true
//                        } else {
                            self.datas.createData(self.email, self.name, self.age, self.gender, self.hometown, self.subject, self.introduction, self.studystyle, self.hobby, self.personality, self.job, self.purpose, self.imageURL)
                            
                            //                    Authの処理
                            self.datas.signUp(self.email, self.password) { (res, err) in
                                if err != nil{
                                    print("Signup失敗...")
                                } else {
                                    self.datas.listen()
                                    print("Signup成功！")
                                    self.showingCompletion = true
                                }
                                
                            }
//                        }
                        
                        
                    }) {
                        Text("登録する").padding()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05)
                            .foregroundColor(self.shareData.white)
                            .background(self.buttonColor).cornerRadius(10)
                        .shadow(radius: 2, y:2)
                    }.disabled(!self.allSectionsFilled)
                    
                    Button("戻る"){
                        self.presentation.wrappedValue.dismiss()
                    }.foregroundColor(self.shareData.white)
                    .shadow(radius: 2, y:2)
                    
                    
                } //vstack
                    .alert(isPresented: self.$showingCompletion) {
                        Alert(title: Text("登録が完了しました"),
                              message: Text("トップページよりログインしてください"),
                              dismissButton: .default(Text("OK"),
                                                      action: {self.pre.dismiss()}))
                }
                    
                .sheet(isPresented: self.$shown) {
                    imagePicker(shown: self.$shown, imageURL: self.$imageURL, email:self.$email)
                }
                    
                    
                .animation(.spring())
                .navigationBarTitle("プロフィール作成", displayMode: .inline)
                .navigationBarItems(leading: Button("戻る"){
                    self.presentation.wrappedValue.dismiss()
                }.foregroundColor(self.shareData.white))
                    .navigationBarBackButtonHidden(true)
            }
        } //geometry
    }
    //        }//group
    //    }
}


//struct PictureUploadView_Previews: PreviewProvider {
//    static var previews: some View {
//        PictureUploadView()
//    }
//}
