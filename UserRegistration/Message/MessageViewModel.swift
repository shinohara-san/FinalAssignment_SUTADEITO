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
    var date: String
//    var hinichi: String
    var matchId : String
}


class MessageViewModel: ObservableObject {
//    var datas = FirebaseData()
    let db = Firestore.firestore()
    
    @Published var matchId:String
    
    @Published var messages:[Message]
    
//    @Published var order: Bool
 
    init(matchId: String){
        self.matchId = matchId
//        self.sharedData = shareData
//        self.order = false
        self.messages = [Message]()
//        イニシャライザ（initializer）とは、コンストラクタのようにインスタンス生成時に自動で呼び出されるメソッドのことです。
        
        self.db.collection("Messages").whereField("matchId", isEqualTo: self.matchId).order(by: "date",descending: false).addSnapshotListener { (snap, error) in
           
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
                        let timestamp: Timestamp = i.document.get("date") as! Timestamp
                        let dateValue = timestamp.dateValue()
                        let f = DateFormatter()
                           f.locale = Locale(identifier: "ja_JP")
//                           f.dateStyle = .none
                           f.dateStyle = .short
                           f.timeStyle = .short
                           let date = f.string(from: dateValue)
                        
//                        let f2 = DateFormatter()
//                        f2.locale = Locale(identifier: "ja_JP")
//                        f2.dateStyle = .full
//                        f2.timeStyle = .none
//                        let hinichi = f2.string(from: dateValue)
//                        let matchId = i.document.get("matchId") as! String
                        

                        self.messages.append(Message(id: id, msg: message, fromUser: fromUser, toUser: toUser, date: date, matchId: matchId))
//                         hinichi: hinichi,
                       
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
            print("メッセージを送信しましたー")
        }
        

//func
    
    
}//class
    
//    func reverse(){
//        if messages.count > 11 {
//            order = true
//        } else {
//            order = false
//        }
//        print("order: \(order)")
//    }
}
