//
//  MessageViewModel.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/24.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Message: Identifiable {
    var id: String
    var msg: String
    var fromUser: String
    var toUser: String
    var date: Timestamp
}


class MessageViewModel: ObservableObject {
    var datas = FirebaseData()
    let db = Firestore.firestore()
//    let matchUser: User
    
    @Published var messages = [Message]()
    
    init(){
        
//        getCurrentUserId()
//        .document(currentUserId).collection("messageRoom").order(by: "date")
        db.collection("Messages").order(by: "date").addSnapshotListener { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
                for i in snap.documentChanges {
                    if i.type == .added {
                        let toUser = i.document.get("toUser") as! String
                        let fromUser = i.document.get("fromUser") as! String
                        let message = i.document.get("message") as! String
                        let id = i.document.documentID
                        let date = i.document.get("date") as! Timestamp
                        
                        self.messages.append(Message(id: id, msg: message, fromUser: fromUser, toUser: toUser, date: date))

                    }
                }
            }
        }
    }
    
    
    
    func sendMsg(msg: String, toUser: String, fromUser: String){
        let data1 = [
            "message": msg,
            "toUser": toUser,
            "fromUser": fromUser,
            "date": Timestamp()
            ] as [String : Any]
        
        db.collection("Messages").addDocument(data: data1){ error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            print("メッセージを送信しました")
        }
        
        
}//func
}//class
