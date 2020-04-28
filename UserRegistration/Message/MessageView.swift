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
    var matchUserInfo: User
//    @State var messages = [Message]()
//    @State var matchId = ""
    //Ll73RINefGxEcYQJoWSE KrR6LQOwrbW9TJeffjYJ
    
    @ObservedObject var msgVM = MessageViewModel(matchId: "")
    
    @EnvironmentObject var shareData : ShareData
    @State var text = ""
    var body: some View {
        VStack{
            
            List(self.msgVM.messages, id: \.id){ i in
                if i.fromUser == self.shareData.currentUserData["id"] as? String ?? ""
//                    && i.toUser == self.matchUserInfo.id
                {
                    MessageRow(message: i.msg, isMyMessage: true)
                } else if  i.toUser == self.shareData.currentUserData["id"] as? String ?? ""
//                　i.fromUser == self.matchUserInfo.id &&
                {
                    MessageRow(message: i.msg, isMyMessage: false)
                }
            }
            .onAppear { UITableView.appearance().separatorStyle = .none }
            .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
            
            HStack{
                TextField("メッセージ", text: $text).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                Button(action: {
                    if self.text.count > 0 {
//                        print("送信時マッチID: \(self.msgVM.matchId)") ok
                          self.msgVM.sendMsg(msg: self.text, toUser: self.matchUserInfo.id, fromUser: self.shareData.currentUserData["id"] as! String, matchId: self.msgVM.matchId)
                        
                        self.text = ""
                    }
                    
                }) {
                    Image(systemName: "paperplane")
                }.padding(.trailing)
            }
            
        }
        .navigationBarTitle("\(self.matchUserInfo.name)", displayMode: .inline)
            .onAppear{
//                self.msgVM.messages = [Message]()shino@aaa.com
//                DispatchQueue.global().async{
                self.getMatchId(partner: self.matchUserInfo)
                print("MessageViewでのmessages: \(self.msgVM.messages)")//空っぽ
//                }
        }
            
        
        .onDisappear{
            //            self.shareData.matchRoomId = ""sss@aaa.com
        }
    }
    
    func getMatchId(partner: User){
        Firestore.firestore().collection("MatchTable").document(self.shareData.currentUserData["id"] as? String ?? "").collection("MatchUser").whereField("MatchUserId", isEqualTo: partner.id).getDocuments { (snap, err) in
            if let snap = snap {
                for id in snap.documents{
                    self.msgVM.matchId = id.data()["MatchRoomId"] as? String ?? "nilだよ"
                    print("MatchId＠ゲットマッチID is \(self.msgVM.matchId)")
                    _ = MessageViewModel(matchId: self.msgVM.matchId) //
                    
                }
            }
            
        }
     
    }
}
