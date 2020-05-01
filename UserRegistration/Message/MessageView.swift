//
//  MessageView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/23.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI
import FirebaseFirestore


struct MessageView: View {
    
    
    let matchUserInfo: User
    let matchRoomId: String

    @ObservedObject private var msgVM: MessageViewModel

    init(_ user: User, _ id:String) {
        self.matchUserInfo = user
        self.matchRoomId = id
        //_　アンダーバーつけるとtypeじゃなくなりエラー消える 
        self._msgVM = ObservedObject(initialValue: MessageViewModel(matchId: matchRoomId))
    }
    
    @EnvironmentObject var shareData : ShareData
    @State var text = ""
    @State var matchId = ""
    
    var body: some View {
        
        VStack{
            List(self.msgVM.messages, id: \.id){ i in
                if i.fromUser == self.shareData.currentUserData["id"] as? String ?? "" {
                    MessageRow(message: i.msg, isMyMessage: true)
                } else {
                    MessageRow(message: i.msg, isMyMessage: false)
                }
             }
            .onAppear { UITableView.appearance().separatorStyle = .none }
            .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
            
//            }
            HStack{
                TextField("メッセージ", text: $text).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                Button(action: {
                    if self.text.count > 0 {
                        print("送信時マッチID: \(self.msgVM.matchId)")
                          self.msgVM.sendMsg(msg: self.text, toUser: self.matchUserInfo.id, fromUser: self.shareData.currentUserData["id"] as! String, matchId: self.msgVM.matchId)
                        
                        self.text = ""
                        print("MessageViewでの送信後のmessages: \(self.msgVM.messages)")
                    }
                    
                }) {
                    Image(systemName: "paperplane")
                }.padding(.trailing)
            }
            
        }
        .navigationBarTitle("\(self.matchUserInfo.name)", displayMode: .inline)
            .onAppear{

                print("MessageViewでのmessages: \(self.msgVM.messages)")//空っぽ
                
        }
            
        
        .onDisappear{
            self.msgVM.messages = [Message]()
        }
    }
    
    func getMatchId(partner: User){
        Firestore.firestore().collection("MatchTable").document(self.shareData.currentUserData["id"] as? String ?? "").collection("MatchUser").whereField("MatchUserId", isEqualTo: partner.id).getDocuments { (snap, err) in
            if let snap = snap {
                for id in snap.documents{
                    self.msgVM.matchId = id.data()["MatchRoomId"] as? String ?? "nilだよ"
                    print("MatchId＠ゲットマッチID is \(self.msgVM.matchId)")
                    _ = MessageViewModel(matchId: self.msgVM.matchId) //ok
                    print("メッセージビューも\(self.msgVM.messages)")
                }
            }
            
        }
     
    }
    
    
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
