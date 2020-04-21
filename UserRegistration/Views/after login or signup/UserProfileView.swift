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
        "id" : dbCollection.document().documentID,
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

//        db.collection("FavoriteTable").whereField("FavoriteUserId", isEqualTo: user.id)
//       .addSnapshotListener { querySnapshot, error in
//           guard let snapshot = querySnapshot else {
//               print("Error fetching snapshots: \(error!)")
//               return
//           }
//           snapshot.documentChanges.forEach { diff in
//               if (diff.type == .added) {
//                   print("New city: \(diff.document.data())")
//               }
//               if (diff.type == .modified) {
//                   print("Modified city: \(diff.document.data())")
//               }
//               if (diff.type == .removed) {
//                   print("Removed city: \(diff.document.data())")
//               }
//           }
//       }
//        print("お気にいりから削除: \(self.user.name)")
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
                //反応なし -> つまりnilはない
                self.isFavorite = false
            }
        }
    }
    
    
    var body: some View {
        VStack{
            FirebaseImageView(imageURL: user.photoURL)
            Text(self.user.name)
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
            
        }.onAppear(perform: checkFavoriteTable)
    }
}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//    }
//}
