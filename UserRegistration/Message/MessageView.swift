//
//  MessageView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/23.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI


struct MessageView: View {
    var matchUserInfo: User
//    @Binding var messageOn: Bool
    @ObservedObject var msgVM = MessageViewModel()
//    let msgVM1 = msgVM.init()
    @EnvironmentObject var shareData : ShareData
    @State var text = ""
    var body: some View {
        VStack{
            
            List(self.msgVM.messages, id: \.id){ i in
                if i.fromUser == self.shareData.currentUserData["id"] as? String ?? "" && i.toUser == self.matchUserInfo.id {
                    MessageRow(message: i.msg, isMyMessage: true)
                } else if i.fromUser == self.matchUserInfo.id && i.toUser == self.shareData.currentUserData["id"] as? String ?? "" {
                    MessageRow(message: i.msg, isMyMessage: false)
                }
            }
            .onAppear { UITableView.appearance().separatorStyle = .none }
            .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
            ///問題点　
            ///２、メッセージを送信すると、他のページでは１行開いちゃう
            
            HStack{
                TextField("メッセージ", text: $text).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                Button(action: {
                    if self.text.count > 0 {
                        print("メッセージ送信 \(self.text)")
                        self.msgVM.sendMsg(msg: self.text, toUser: self.matchUserInfo.id, fromUser: self.shareData.currentUserData["id"] as! String)
                       
                        self.text = ""
                    }
                    
                }) {
                    Image(systemName: "paperplane")
                }.padding(.trailing)
            }
            
        }.navigationBarTitle("\(self.matchUserInfo.name)", displayMode: .inline)
//        .onAppear{
//            self.shareData.messageModel()
//        }
    }
}

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView()
//    }
//}
