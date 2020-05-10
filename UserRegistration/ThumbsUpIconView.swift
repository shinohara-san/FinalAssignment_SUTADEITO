//
//  ThumbsUpIconView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/10.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct ThumbsUpIconView: View {
    var user: User
    var body: some View {
        HStack{
            if user.place == "カフェ" && user.schedule == "日中" && user.studystyle != "勉強はせずにお話をしてみたい" && user.studystyle != "その他"{
                Image(systemName: "hand.thumbsup.fill").foregroundColor(.yellow)
            }
            Text(user.name)
        }

    }
}

//
//struct ThumbsUpIconView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThumbsUpIconView()
//    }
//}
