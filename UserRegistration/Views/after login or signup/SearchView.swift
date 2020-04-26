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
    @State var hometown = ""
    @State var purpose = ""
    @State var subject = ""
    var body: some View {
        VStack{
             Text("条件を入れてください")
            VStack{
            HStack{
                TextField("居住地", text: $hometown).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                Button("検索"){
                    print(self.hometown)
                }.padding(.trailing)
            }
            HStack{
                TextField("目的", text: $purpose).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                Button("検索"){
                    print(self.purpose)
                }.padding(.trailing)
            }
            HStack{
                TextField("科目", text: $subject).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                Button("検索"){
                    print(self.subject)
                }.padding(.trailing)
            }
            }
            Divider()
            Spacer()
            //ユーザーリスト
        }
       
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
