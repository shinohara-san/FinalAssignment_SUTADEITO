//
//  MessageViewModel.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/24.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.


import Foundation
import FirebaseFirestore

//let messageViewModel = MessageViewModel()

struct Message: Identifiable {
    var id: String
    var msg: String
    var fromUser: String
    var toUser: String
    var date: Timestamp
    var matchId : String
}


class MessageViewModel: ObservableObject {
//    var datas = FirebaseData()
    let db = Firestore.firestore()
    
    @Published var matchId:String
    
    @Published var messages:[Message]
 
    init(matchId: String){
        self.matchId = matchId
//        self.sharedData = shareData
        self.messages = [Message]()
//        イニシャライザ（initializer）とは、コンストラクタのようにインスタンス生成時に自動で呼び出されるメソッドのことです。
//        print("loop用マッチID: \(self.matchId)")
//        DispatchQueue.main.async {
        
        self.db.collection("Messages").whereField("matchId", isEqualTo: self.matchId).order(by: "date").addSnapshotListener { (snap, error) in
           
//            DispatchQueue.global().sync {
            if let error = error {
                print(error.localizedDescription)
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
//                      DispatchQueue.global().async {
                        self.messages.append(Message(id: id, msg: message, fromUser: fromUser, toUser: toUser, date: date, matchId: matchId))
//                        }
//                        self.messages = []
//                        print("messagesの中身: \(self.messages)") //Ok
                        
                    }
                }
            }
        }
//    }
    }// init閉じ
//}
    
    
    
    func sendMsg(msg: String, toUser: String, fromUser: String, matchId: String){
//        self.matchId = matchId
        let data = [
            "message": msg,
            "toUser": toUser,
            "fromUser": fromUser,
            "date": Timestamp(),
            "matchId": matchId
            ] as [String : Any]
        
        Firestore.firestore().collection("Messages").addDocument(data: data){ error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            print("メッセージを送信しました")
        }
        

//func
    
    
}//class
}
