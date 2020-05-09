//
//  ProfileUserDetailView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/22.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct ProfileUserDetailView: View {
    @EnvironmentObject var shareData: ShareData
    var name: String
    var age:String
    var gender:String
    var hometown:String
    var subject:String
    var introduction:String
    var studystyle:String
    var hobby:String
    var personality:String
    var work:String
    var purpose:String
    var fee:String
    var schedule:String
    var place:String
    
    
    struct InfoRow : View{
        @EnvironmentObject var shareData: ShareData
        var title : String
        var info : String
        
        var body: some View{
            
            HStack{
                Text(title).foregroundColor(shareData.black)
                Spacer()
                Text(info).foregroundColor(shareData.black)
            }.padding(.bottom, 20)
            
        }
    }
    
    var body: some View {
        VStack{
            Section{
                
                VStack{
                    Text("基本情報").font(.title).fontWeight(.bold).padding(.bottom)
                    InfoRow(title: "名前:", info: self.name)
                    InfoRow(title: "年齢:", info: self.age)
                    InfoRow(title: "現住所:", info: self.hometown)
                    InfoRow(title: "趣味:", info: self.hobby)
                    InfoRow(title: "職業:", info: self.work)
                    InfoRow(title: "性格:", info: self.personality)
                    InfoRow(title: "自己紹介:", info: self.introduction)
                    
                    
                }
            }.padding().background(self.shareData.white2).cornerRadius(10).shadow(radius: 2, y: 2).padding(.bottom)
            
            Section{
                
                VStack{
                    Text("すたでいと").font(.title).fontWeight(.bold).padding(.bottom)
                    if self.place == "カフェ" && self.schedule == "日中" && self.studystyle != "勉強はせずにお話をしてみたい" && self.studystyle != "その他"{
                        Text("このユーザーは「すたでいと」ユーザーです").font(.subheadline).foregroundColor(.yellow).fontWeight(.bold).padding(.bottom)
                    }
                    InfoRow(title: "勉強中:", info: self.subject)
                    InfoRow(title: "希望するすたでいと:", info: self.studystyle)
                    InfoRow(title: "希望する時間帯:", info: self.schedule)
                    InfoRow(title: "希望する場所:", info: self.place)
                    InfoRow(title: "デート代:", info: self.fee)
                    InfoRow(title: "目的:", info: self.purpose)
                    
                }
                
            }.padding().background(self.shareData.white2).cornerRadius(10).shadow(radius: 2, y: 2).padding(.bottom)
        }
    }
}
//    struct ProfileUserDetailView_Previews: PreviewProvider {
//        static var previews: some View {
//            ProfileUserDetailView()
//        }
//}
