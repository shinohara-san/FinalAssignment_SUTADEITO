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
    var fee:String
    var schedule:String
    var place:String
    
    
    var body: some View {
        VStack{
            HStack{
                Text("名前")
                Spacer()
                Text(self.name)
            }.padding(.bottom, 20)
            
            HStack{
                Text("年齢")
                Spacer()
                //                Text(String(describing: self.currentUser["age"] ?? ""))
                Text(self.age)
            }.padding(.bottom, 20)
            HStack{
                Text("勉強中")
                Spacer()
                Text(self.subject)
            }.padding(.bottom, 20)
            HStack{
                Text("現住所")
                Spacer()
                Text(self.hometown)
            }.padding(.bottom, 20)
            HStack{
                Text("趣味")
                Spacer()
                Text(self.hobby)
            }.padding(.bottom, 20)
            HStack{
                Text("自己紹介")
                Spacer()
                Text(self.introduction)
            }.padding(.bottom, 20)
            HStack{
                Text("性格")
                Spacer()
                Text(self.personality)
            }.padding(.bottom, 20)
            HStack{
                Text("目的")
                Spacer()
                Text(self.purpose)
            }.padding(.bottom, 20)
            Section{
                HStack{
                    Text("希望するすたでいと")
                    Spacer()
                    Text(self.studystyle)
                }.padding(.bottom, 20)
                
                HStack{
                    Text("希望する時間帯")
                    Spacer()
                    Text(self.schedule)
                }.padding(.bottom, 20)
                HStack{
                    Text("デート代")
                    Spacer()
                    Text(self.fee)
                }.padding(.bottom, 20)
                HStack{
                    Text("希望する場所")
                    Spacer()
                    Text(self.place)
                }.padding(.bottom, 20)
                
                
                
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
