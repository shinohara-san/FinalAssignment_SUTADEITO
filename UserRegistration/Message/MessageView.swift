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
    @State var messages = [Message]()
//    @State var matchId = ""
    //Ll73RINefGxEcYQJoWSE KrR6LQOwrbW9TJeffjYJ
    
//    @ObservedObject var msgVM = MessageViewModel()
    
    @EnvironmentObject var shareData : ShareData
    @State var text = ""
    var body: some View { //sayaka@aaa.com
        VStack{
            
            List(self.messages, id: \.id){ i in
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
                        print("送信時マッチID: \(self.shareData.matchId)")
                        print("メッセージ送信 \(self.text)")
                        self.shareData.sendMsg(msg: self.text, toUser: self.matchUserInfo.id, fromUser: self.shareData.currentUserData["id"] as! String, matchId: self.shareData.matchId)
                        
                        self.text = ""
                    }
                    
                }) {
                    Image(systemName: "paperplane")
                }.padding(.trailing)
            }
            
        }.navigationBarTitle("\(self.matchUserInfo.name)", displayMode: .inline)
            .onAppear{
//                DispatchQueue.global().async{。
                self.shareData.getMatchId(partner: self.matchUserInfo)
//                }
                //                }
                //                    DispatchQueue.global().async {
                //                DispatchQueue.global(qos: .utility).async {
                print("マッチID onAppear: \(self.shareData.matchId)")
                //                self.msgVM.matchId = self.matchId
                //
                self.messageManager() //documentChangesとかの
                //                    }
        }
            
            //            }
        
        .onDisappear{
            //            self.shareData.matchRoomId = ""sss@aaa.com
        }
    }
    

    
    func messageManager() {
        print("ゲットデータ: \(self.shareData.matchId)")
        let db = Firestore.firestore()
        db.collection("Messages").whereField("matchId", isEqualTo: self.shareData.matchId).order(by: "date").addSnapshotListener { (snap, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }

            if let snap = snap {
                for i in snap.documentChanges {
                    
                    if i.type == .added{
                        let toUser = i.document.get("toUser") as! String
                        let fromUser = i.document.get("fromUser") as! String
                        let message = i.document.get("message") as! String
                        let id = i.document.documentID
                        let date = i.document.get("date") as! Timestamp
                        let matchId = i.document.get("matchId") as! String
                       
//                        DispatchQueue.main.async {
                       
                            self.messages.append(Message(id: id, msg: message, fromUser: fromUser, toUser: toUser, date: date, matchId: matchId))
                          
                            
//                        }
                    }
                }
            }
            //            }
        }
    }
    
    
    
    
    
}

struct Message: Identifiable {
    var id: String
    var msg: String
    var fromUser: String
    var toUser: String
    var date: Timestamp
    var matchId : String
}

