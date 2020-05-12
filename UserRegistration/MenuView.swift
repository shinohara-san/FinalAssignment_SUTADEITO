//
//  MenuView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/05.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var shareData: ShareData
    var body: some View {
        ZStack{
            self.shareData.white
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline){
            Image(systemName: "hand.thumbsup.fill")
                .foregroundColor(.yellow)
                Text("「すたでいと」ユーザーとは？")
                    .foregroundColor(self.shareData.black)
            }.font(.title).padding()
            Text("「日中」「カフェ」「勉強したい」をプロフィールで選択しているユーザーです。").foregroundColor(self.shareData.black).padding()
            Text("あなたも「すたでいと」ユーザーになって、他のユーザーにアピールをしましょう。").foregroundColor(self.shareData.black).padding()
            Spacer()
            Divider()
            Text("Settings and privacy").padding()
        }
//        .padding(.horizontal, 20)
    }//zs
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
