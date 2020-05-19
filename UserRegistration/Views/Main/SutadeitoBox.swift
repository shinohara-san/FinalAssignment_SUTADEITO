//
//  SutadeitoBox.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/12.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//b

import SwiftUI

struct SutadeitoBox: View {
    @Binding var menuOn: Bool
    @EnvironmentObject var shareData: ShareData
    var body: some View {
        GeometryReader{ geometry in
        VStack{
       HStack(alignment: .firstTextBaseline){
        Image(systemName: "hand.thumbsup.fill")
            .foregroundColor(.yellow)
            Text("すたでいとユーザーとは？")
                .foregroundColor(Color.myBlack)
        }.padding()
        Text("「日中」「カフェ」「勉強したい」をプロフィールで選択しているユーザーです。")
//            .font(.subheadline)
            .foregroundColor(Color.myBlack).padding()
        Text("すたでいとユーザーになって、他のユーザーにアピールしましょう。")
//            .font(.subheadline)
            .foregroundColor(Color.myBlack).padding()
            
            HStack{
                Button(action: {
                    self.menuOn = false
                }) {
                    HStack{
                        Image(systemName: "multiply")
                        Text("閉じる")
                    }
                }
            }.padding(.bottom)
            }.background(Color.myWhite2).cornerRadius(10).frame(width: geometry.size.width * 0.8)
        }
    }
}

//struct SutadeitoBox_Previews: PreviewProvider {
//    static var previews: some View {
//        SutadeitoBox()
//    }
//}
