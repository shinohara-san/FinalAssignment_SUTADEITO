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
        db.collection("LikeTable").document(self.shareData.currentUserData["id"] as! String).setData([
            "id" : db.collection("Users").document().documentID,
            "LikeUserId": user.id])
        print("いいね: \(self.user.id)")
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
            
            Button("いいね"){
                self.giveUserLike()
            }
            
        }
        .onAppear{
            self.checkFavoriteTable()
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
