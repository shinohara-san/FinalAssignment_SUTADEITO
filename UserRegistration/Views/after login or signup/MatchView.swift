//
//  MatchView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct MatchView: View {
    @EnvironmentObject var shareData: ShareData
    
    var body: some View {
        VStack{
            ForEach(self.shareData.matchUserArray){ user in
                Text(user.name)
            }
        }
        
        .onAppear{
            self.shareData.getAllMatchUser()
//            print(self.shareData.matchUserArray)
        }
    } //body
    
} //struct

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
    }
}
