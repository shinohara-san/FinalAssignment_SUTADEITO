//
//  TopPageView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/16.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct TopPageView: View {
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination: LoginView()) {
                    Text("ログイン")
                }.padding(.bottom)
                NavigationLink(destination: RegisterView()) {
                    Text("新規登録")
                }
            }
            
        }
        
    }
}

struct TopPageView_Previews: PreviewProvider {
    static var previews: some View {
        TopPageView()
    }
}
