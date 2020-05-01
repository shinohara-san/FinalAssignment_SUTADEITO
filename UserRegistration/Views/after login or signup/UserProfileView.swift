//
//  UserProfileView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/20.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct UserProfileView: View {
    var user: User //mainviewから来た
    @State var isFavorite = false
    @State var gaveLike = false
    let db = Firestore.firestore()
    @EnvironmentObject var shareData: ShareData
    
    @State var roomId = ""
    
    func giveUserLike(){
        
        db.collection("LikeTable").whereField("LikeUserId", isEqualTo: user.id).whereField("MyUserId", isEqualTo: self.shareData.currentUserData["id"] as! String).getDocuments { (snap, err) in
            if err != nil{
                return
            }
            if snap!.count > 0{
                print("おなじユーザーにいいねしてるよ")
                return
            }
            self.db.collection("LikeTable").addDocument(data: [
                "LikeUserId": self.user.id,
                "MyUserId": self.shareData.currentUserData["id"] as! String
            ])
            self.gaveLike = true
            //addDocumentを使うことで自動生成idの下にデータ保存できる
            print("いいねに追加: \(self.user.name)")
            ///一覧から削除
            
            self.checkMatch()
        }
    }
    
    
    func removeUserFromLike(){
        db.collection("LikeTable")
            .whereField("LikeUserId", isEqualTo: user.id).whereField("MyUserId", isEqualTo: self.shareData.currentUserData["id"] as! String).getDocuments { (snap, err) in
                if err != nil {
                    return
                }
                if let snap = snap {
                    for user in snap.documents{
                        user.reference.delete()
                        self.gaveLike = false
                        print("\(self.user.name)へのいいねを取り消しました")
                    }
                }
        }
        
    }
    
    
    
    
    //    マッチチェック
    func checkMatch(){
        db.collection("LikeTable").whereField("LikeUserId", isEqualTo: self.shareData.currentUserData["id"] as! String).whereField("MyUserId", isEqualTo: user.id).getDocuments { (snap, err) in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            
            if let snap = snap{
                for i in snap.documents{
                    print("マッチ！")
                    
                    ///マッチテーブル作成
                    
                    //                ルーム作る
                    var ref: DocumentReference? = nil
                    DispatchQueue.global().sync {
                        ref = self.db.collection("MatchRoom").addDocument(data: [
                            "matchUser1": i.data()["MyUserId"] as? String ?? "",
                            "matchUser2": i.data()["LikeUserId"] as? String ?? ""
                        ]) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                
                                print("Document added with ID: \(ref!.documentID)")
                                self.roomId = ref!.documentID
                                
                                
                                //       iにはliketableのinfo                         MatchIdの入った相手のUserData
                                self.db.collection("Users").whereField("id", isEqualTo: i.data()["MyUserId"] as? String ?? "").getDocuments { (snap, err) in
                                    if let snap = snap {
                                        for i in snap.documents{
                                            let user = i.data()
                                            
                                            self.db.collection("MatchUsers").document(self.shareData.currentUserData["id"] as! String).collection("MatchUserData").document().setData([
                                                "MatchRoomId" : self.roomId,
                                                "email": user["email"] as! String,
                                                "name": user["name"] as! String,
                                                "age":  user["age"] as! String,
                                                "gender":  user["gender"] as! String,
                                                "hometown":  user["hometown"] as! String,
                                                "subject":  user["subject"] as! String,
                                                "introduction":  user["introduction"] as! String,
                                                "studystyle":  user["studystyle"] as! String,
                                                "hobby":  user["hobby"] as! String,
                                                "personality":  user["personality"] as! String,
                                                "work":  user["work"] as! String,
                                                "purpose":  user["purpose"] as! String,
                                                "photoURL":  user["photoURL"] as! String,
                                                "id": self.shareData.currentUserData["id"] as? String ?? ""
                                                
                                            ]){ err in
                                                if let err = err {
                                                    print("Error writing document: \(err)")
                                                } else {
                                                    print("Document successfully written!")
                                                }
                                            }
                                            
                                            
                                        }
                                    }
                                }
                                
                                self.db.collection("Users").whereField("id", isEqualTo: i.data()["LikeUserId"] as? String ?? "").getDocuments { (snap, err) in
                                    if let snap = snap {
                                        for j in snap.documents{
                                            let user = j.data()
                                            
                                            self.db.collection("MatchUsers").document(i.data()["MyUserId"] as? String ?? "").collection("MatchUserData").document().setData([
                                                "MatchRoomId" : self.roomId,
                                                "email": user["email"] as! String,
                                                "name": user["name"] as! String,
                                                "age":  user["age"] as! String,
                                                "gender":  user["gender"] as! String,
                                                "hometown":  user["hometown"] as! String,
                                                "subject":  user["subject"] as! String,
                                                "introduction":  user["introduction"] as! String,
                                                "studystyle":  user["studystyle"] as! String,
                                                "hobby":  user["hobby"] as! String,
                                                "personality":  user["personality"] as! String,
                                                "work":  user["work"] as! String,
                                                "purpose":  user["purpose"] as! String,
                                                "photoURL":  user["photoURL"] as! String,
                                                "id": i.data()["LikeUserId"] as? String ?? ""
                                                
                                            ]){ err in
                                                if let err = err {
                                                    print("Error writing document: \(err)")
                                                } else {
                                                    print("Document successfully written!")
                                                }
                                            }
                                            
                                            
                                        }
                                    }
                                }
                                
                                //                自分用マッチテーブル
                                self.db.collection("MatchTable").document(i.data()["MyUserId"] as? String ?? "").collection("MatchUser").document().setData([
                                    "MatchUserId": i.data()["LikeUserId"] as? String ?? "",
                                    "MyUserId": i.data()["MyUserId"] as? String ?? "",
                                    "MatchRoomId": self.roomId
                                ])
                                //                相手用マッチテーブル
                                self.db.collection("MatchTable").document(i.data()["LikeUserId"] as? String ?? "").collection("MatchUser").document().setData([
                                    "MatchUserId": i.data()["MyUserId"] as? String ?? "",
                                    "MyUserId": i.data()["LikeUserId"] as? String ?? "",
                                    "MatchRoomId": self.roomId
                                ])
                            }
                        }
                        
                    }
                    
                    
                    ///マッチ後マッチユーザー同士をお気に入りから削除
                    self.db.collection("FavoriteTable").document(i.data()["MyUserId"] as? String ?? "").collection("FavoriteUser").whereField("FavoriteUserId", isEqualTo: i.data()["LikeUserId"] as? String ?? "").getDocuments { (snap, err) in
                        if err != nil {
                            return
                        }
                        if let snap = snap {
                            for user in snap.documents{
                                user.reference.delete()
                                print("マッチしたのでお気に入りから削除しました。")
                            }
                        }
                    }
                    
                    self.db.collection("FavoriteTable").document(i.data()["LikeUserId"] as? String ?? "").collection("FavoriteUser").whereField("FavoriteUserId", isEqualTo: i.data()["MyUserId"] as? String ?? "").getDocuments { (snap, err) in
                        if err != nil {
                            return
                        }
                        if let snap = snap {
                            for user in snap.documents{
                                user.reference.delete()
                                print("マッチしたのでお気に入りから削除しました。")
                            }
                        }
                    }
                    
                    ///マッチ後お互いをいいねユーザーから削除
                    
                    self.db.collection("LikeTable").whereField("LikeUserId", isEqualTo: i.data()["LikeUserId"] as? String ?? "").getDocuments { (snap, err) in
                        if err != nil {
                            return
                        }
                        if let snap = snap {
                            for user in snap.documents{
                                user.reference.delete()
                                print("マッチしたのでいいねから削除しました。")
                            }
                        }
                    }
                    
                    self.db.collection("LikeTable").whereField("LikeUserId", isEqualTo: i.data()["MyUserId"] as? String ?? "").getDocuments { (snap, err) in
                        if err != nil {
                            return
                        }
                        if let snap = snap {
                            for user in snap.documents{
                                user.reference.delete()
                                print("マッチしたのでいいねから削除しました。")
                            }
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
    func addUserToFavorite(){
        db.collection("FavoriteTable").document(self.shareData.currentUserData["id"] as! String).collection("FavoriteUser").document(user.id).setData([
            //        "id" : dbCollection.document().documentID,
            "FavoriteUserId": user.id,
            "MyUserId": self.shareData.currentUserData["id"] as! String //お気に入り表示で引っ張ってくるときに効率的
        ])
        print("お気にいりに追加: \(self.user.name)")
    }
    
    func removeUserFromFavorite(){
        db.collection("FavoriteTable")
            .document(self.shareData.currentUserData["id"] as! String)
            .collection("FavoriteUser")
            .document(user.id)
            .delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("お気にいりから削除: \(self.user.name)")
                }
        }
        
    }
    
    
    
    func checkFavoriteTable() {
        db.collection("FavoriteTable").document(self.shareData.currentUserData["id"] as! String).collection("FavoriteUser").document(user.id).getDocument { (document, err) in
            
            if document?.data()?.count != nil {
                //                print(document?.data())
                self.isFavorite = true 
            } else {
                //反応なし -> つまりdata()のnilはない.でもcountだとnilになる
                self.isFavorite = false
            }
        }
    }
    
    func checkLikeTable() {
        db.collection("LikeTable").whereField("LikeUserId", isEqualTo: user.id).whereField("MyUserId", isEqualTo: self.shareData.currentUserData["id"] as! String).getDocuments { (snap, err) in
            if err != nil{
                print(err?.localizedDescription as Any)
                return
            }
            if let snap = snap {
                if snap.count > 0{
                    self.gaveLike = true
                    return
                } else {
                    self.gaveLike = false
                }
            }
        }
    }
    
//    @Binding var userProfileOn: Bool
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                
                self.shareData.white.edgesIgnoringSafeArea(.all)
                VStack{
                    
                    FirebaseImageView(imageURL: self.user.photoURL).frame(width: geo.size.width * 0.9, height: geo.size.height * 0.4).cornerRadius(10)
                    
                    ProfileUserDetailView(name: self.user.name, age: self.user.age, gender: self.user.gender, hometown: self.user.hometown, subject: self.user.subject, introduction: self.user.introduction, studystyle: self.user.studystyle, hobby: self.user.hobby, personality: self.user.personality, work: self.user.work, purpose: self.user.purpose).frame(width: geo.size.width * 0.9)
                    
                    
                    Button(action: {
                        self.checkFavoriteTable()
                        
                        if self.isFavorite == false {
                            self.addUserToFavorite()
                        } else {
                            self.removeUserFromFavorite()
                        }
                    }) {
                        Text(self.isFavorite ? "お気に入りから削除" : "お気に入りに追加")
                    }
                    
                    Button(action: {
                        self.checkLikeTable()
                        
                        if self.gaveLike == false {
                            self.giveUserLike()
                        } else {
                            self.removeUserFromLike()
                        }
                    }) {
                        Text(self.gaveLike ? "いいねを取り消す" : "いいね")
                    }
                    
                    
                }
            }
        }
        .onAppear{
            self.checkFavoriteTable()
            self.checkLikeTable()
            //            print("プロフィールに来た")
        }
        .onDisappear{
            //            print("プロフィールを去った")
        }
        .navigationBarTitle("")
        .navigationBarHidden(false)
    }
}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//    }
//}
