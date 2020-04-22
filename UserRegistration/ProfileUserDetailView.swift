//
//  ProfileUserDetailView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/22.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct ProfileUserDetailView: View {
    
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
    
    var body: some View {
        VStack{
            HStack{
                Text("名前")
                Spacer()
                Text(self.name)
            }
            HStack{
                Text("年齢")
                Spacer()
                //                Text(String(describing: self.currentUser["age"] ?? ""))
                Text(self.age)
            }
            HStack{
                Text("勉強中")
                Spacer()
                Text(self.subject)
            }
            HStack{
                Text("現住所")
                Spacer()
                Text(self.hometown)
            }
            HStack{
                Text("趣味")
                Spacer()
                Text(self.hobby)
            }
            HStack{
                Text("自己紹介")
                Spacer()
                Text(self.introduction)
            }
            HStack{
                Text("性格")
                Spacer()
                Text(self.personality)
            }
            HStack{
                Text("目的")
                Spacer()
                Text(self.purpose)
            }
            Section{
                HStack{
                    Text("希望する勉強スタイル")
                    Spacer()
                    Text(self.studystyle)
                }
                HStack{
                    Text("職業")
                    Spacer()
                    Text(self.work)
                }
            }
        }
    }
}
//    struct ProfileUserDetailView_Previews: PreviewProvider {
//        static var previews: some View {
//            ProfileUserDetailView()
//        }
//}
