//
//  SearchView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var shareData: ShareData
    
    var body: some View {
        Text("SearchView here")
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .onAppear{
//            print(self.shareData.currentUserData["name"] ?? "Current user まだは空っぽだよ")
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
