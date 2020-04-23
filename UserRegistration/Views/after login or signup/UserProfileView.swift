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
    var user: User

    let db = Firestore.firestore()
    @EnvironmentObject var shareData: ShareData
    
    func giveUserLike(){

        db.collection("LikeTable").whereField("LikeUserId", isEqualTo: user.id).whereField("MyUserId", isEqualTo: self.shareData.currentUserData["id"] as! String).addSnapshotListener { (snap, err) in
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
            //addDocumentを使うことで自動生成idの下にデータ保存できる
                    print("いいねに追加: \(self.user.name)")
                    ///お気に入りから削除
                    ///一覧から削除
                    ///いいねから削除
                    self.checkUserLike()
                }
        }
    
    ///ここから
        
    func removeUserFromLike(){
        db.collection("LikeTable")
            .whereField("id", isEqualTo: user.id).getDocuments { (snap, err) in
                if err != nil {
                    return
                }
                if let snap = snap {
                    for user in snap.documents{
                        user.reference.delete()
                        print("\(self.user.name)へのいいねを取り消しました")
                    }
                }
        }
        
    }
        
       
    
    
//    マッチチェック
    func checkUserLike(){
        db.collection("LikeTable").whereField("LikeUserId", isEqualTo: self.shareData.currentUserData["id"] as! String).whereField("MyUserId", isEqualTo: user.id).getDocuments { (snap, err) in
        if let err = err{
            print(err.localizedDescription)
            return
        }

        if let snap = snap{
            for i in snap.documents{
                print(i.data())
//                ["LikeUserId": nqIuqrFw8ww1F4FiQUrL, "id": iVpcdD7P6UFi1etqnTtB]
//                self.shareData.givenLikeArray.append(i.data()["LikeUserId"] as? String ?? "")
                print("マッチ！")

//                roomを作る関数
                
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
    
    @State var isFavorite = false
    @State var gaveLike = false
    
    func checkFavoriteTable() {
        db.collection("FavoriteTable").document(self.shareData.currentUserData["id"] as! String).collection("FavoriteUser").document(user.id).getDocument { (document, err) in
            //            print(document?.data()?.count)
            //            print(document?.data())
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
        db.collection("LikeTable").whereField("LikeUserId", isEqualTo: user.id).getDocuments { (document, err) in
            //            print(document?.data()?.count)
            //            print(document?.data())
            if document?.count != nil {
                //                print(document?.data())
                self.gaveLike = true
            } else {
                //反応なし -> つまりdata()のnilはない.でもcountだとnilになる
                self.gaveLike = false
            }
        }
    }
    
    
    var body: some View {
        VStack{
            FirebaseImageView(imageURL: user.photoURL)
            
            ProfileUserDetailView(name: user.name, age: user.age, gender: user.gender, hometown: user.hometown, subject: user.subject, introduction: user.introduction, studystyle: user.studystyle, hobby: user.hobby, personality: user.personality, work: user.work, purpose: user.purpose)
            

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
