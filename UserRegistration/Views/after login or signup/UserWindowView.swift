////
////  UserWindowView.swift
////  UserRegistration
////
////  Created by Yuki Shinohara on 2020/04/20.
////  Copyright © 2020 Yuki Shinohara. All rights reserved.
////
//
////お気に入りユーザー一覧で使う一つ一つの表示用
//
//import SwiftUI
//import FirebaseFirestore
//
////このページをfavoriteに移植したい
//
//struct UserWindowView: View {
//    @EnvironmentObject var shareData : ShareData
//    var userId:String
//
//    var body: some View {
////        NavigationView{
//
//            VStack{ //このview自体が一つのセクションなのでnavilinkはうまく効かない
//
////                FirebaseImageView(imageURL: self.shareData.displayedUser.photoURL)
////                HStack{
////                    Text(self.shareData.displayedUser.name)
////                    Text(self.shareData.displayedUser.hometown)
//                    //displayedUserが一人だから
//
//                ForEach(self.shareData.favoriteUsers, id: \.self){ user in
//                    Text(user.name)
//                }
//
//            }
//        .buttonStyle(PlainButtonStyle())
////        }
//        .onAppear{
////        self.getUserInfo()
//
////            self.shareData.favoriteUserIds = [String]()
//            self.shareData.getUserInfo(userId: self.userId)
//        }
//
//    } //body
//} //全体
//
////struct UserWindowView_Previews: PreviewProvider {
////    static var previews: some View {
////        UserWindowView()
////    }
////}
//
//func getUserInfo(userId: String){
//    db.collection("Users").whereField("id", isEqualTo: userId).getDocuments { (snap, err) in
//        if let err = err {
//            print(err.localizedDescription)
//            return
//        } else {
//            for user in snap!.documents{
//                self.favoriteUsers.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as! String))
//            }
//        }
//    }
//
//}
