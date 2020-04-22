

//マッチのところをどうするか

//お気に入りの表示を修正したい

//チャット

//検索

//各種バリデーション

//ログイン時の時間をFirestoreに保存　→ アイコンの色をそれに応じて変える

//デザイン

//https://www.youtube.com/watch?v=4d-Lx4WtNiM
//loadingアニメーション


//【修正済み】
//プロフィール画像が最初表示されるが、別ページ行って帰ってくるともう二度と表示されない。(遅いけど一応修正)
//居住地, 性別をピッカーに、年齢をスライダーかピッカーに

//新規とうろくしたらあの不具合直る


//
//  MainView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/16.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//
//shino@aaa.com
//　1234shino

//import SwiftUI
//
//struct MainView: View {
//
//    var datas: FirebaseData
//
//    @EnvironmentObject var shareData: ShareData
//
//    @State var selection = 0
//
//    @State var userProfileOn = false
//
//    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
//    var body: some View {
//
//        TabView(selection: $selection) {
//            //            ListView(datas: self.datas)
//            //                NavigationView{
//            Group{
//                if !userProfileOn{
//                    ScrollView{
//                        VStack{
//                            ForEach(self.shareData.allUsers){ user in
//
////                                NavigationLink(destination: UserProfileView(user: user)) {
//                                VStack{
//                                    FirebaseImageView(imageURL: user.photoURL)
//                                    HStack{
//                                        Text("\(user.gender)") //テスト
//                                        Text(user.age)
//                                        Text(user.hometown)
//                                    }
//                                    Text(user.introduction)
//                                    //
//                                }
//                                .onTapGesture {
//                                    self.userInfo = user
//                                    self.userProfileOn = true
//                                }
////                                } //navigationlink
////                                    .buttonStyle(PlainButtonStyle())
//
//                            } //foreach
//                            .buttonStyle(PlainButtonStyle())
//
//                        }//Vstack
//
//
//                            .onAppear{
//                                DispatchQueue.global().sync {
//                                    self.shareData.getCurrentUser() //ログイン中のユーザー情報を取得し、そのあと全表示ユーザー情報取得
//                                    print("リストビュー")
//                                }
//                        }
//                        .onDisappear(){
//                            //                            self.allUsers = [User]()
//                        }
//
//                    }//Scrollview
//                } else {
//                    VStack{
//                        UserProfileView(user: userInfo)
//                        Button("戻る"){
//                            self.userProfileOn = false
//                        }
//                    }
//
//                }
//
//            }//Profile
//
//                .navigationBarTitle("")
//                .navigationBarHidden(false)
//                .tabItem {
//                    VStack {
//                        Image(systemName: "book")
//                    }
//            }.tag(1)
//            SearchView()
//                .tabItem {
//                    VStack {
//                        Image(systemName: "magnifyingglass")
//                    }
//            }.tag(2)
//            FavoriteView()
//
//                .tabItem {
//                    VStack {
//                        Image(systemName: "star")
//                    }
//            }
//            .tag(3)
//
//            MatchView()
//                .tabItem {
//                    VStack {
//                        Image(systemName: "suit.heart")
//                    }
//            }.tag(4)
//            SettingView(datas: self.datas)  //environmentに書き換えたい
//                .tabItem {
//                    VStack {
//                        Image(systemName: "ellipsis")
//                    }
//            }.tag(5)
//        }.onAppear{
//            print("メインビュー")
//        }
//
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//
//    }
//}


//
//struct FavoriteView: View {
//    @EnvironmentObject var shareData: ShareData
//
//    let db = Firestore.firestore()
//    func getUserInfo(favoriteUserId: String){
//        db.collection("Users").whereField("id", isEqualTo: favoriteUserId).getDocuments { (snap, err) in
//            if let err = err {
//                print(err.localizedDescription)
//                return
//            } else {
//                for user in snap!.documents{
//                    self.shareData.favoriteUsers.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as! String))
//                }
//            }
//        }
//
//    }
//
//    func getIds(){
//        db.collection("FavoriteTable").document(self.shareData.currentUserData["id"] as! String).collection("FavoriteUser").getDocuments { (snap, err) in
//            for i in snap!.documents{
//                self.shareData.favoriteUserIds.append(i.data()["FavoriteUserId"] as! String)
////                print(self.shareData.favoriteUserIds)
//            }
//        }
//    }
//
//
////        for favoriteUserId in self.shareData.favoriteUserIds{
//////            self.shareData.favoriteUsers = [User]()
////            self.getUserInfo(favoriteUserId: favoriteUserId)
////        }
////
//
//
//
//    var body: some View {
//            VStack{
//                Text("Favorite view")
////                ForEach(self.shareData.favoriteUserIds){ id in
////                    Text(self.shareData.favoriteUserIds[id])
////                }
////                ForEach(self.displayedUser)
//            }
//
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .onAppear{()
//            self.getIds()
//            self.shareData.getFavoriteUsers()
//            print(self.shareData.favoriteUserIds)
////            print(self.shareData.favoriteUsers)
//        }
//        .onDisappear{
//            self.shareData.favoriteUserIds = []
//        }
//    }
//}
//
//
//struct FavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteView()
//    }
//}


//func getFavoriteUsers(){
//
//       db.collection("FavoriteTable").document(self.currentUserData["id"] as! String).collection("FavoriteUser")
//           //            .whereField("MyUserId", isEqualTo: self.shareData.currentUserData["id"] as! String)
//           .addSnapshotListener { (snap, err) in
//
//               guard let snapshot = snap else {
//                   print("Error fetching snapshots: \(err!)")
//                   return
//               }
//               snapshot.documentChanges.forEach { diff in
//                   if (diff.type == .added) {
//                       //                        print("New favorite:  \(diff.document.data()["FavoriteUserId"] ?? "")")
//                       self.favoriteUserIds.append(diff.document.data()["FavoriteUserId"] as! String)
//                   }
//                   //                    if (diff.type == .modified) {
//                   //                        print("Modified city: \(diff.document.data())")
//                   //                    }
//                   if (diff.type == .removed) {
//                       //                        print("Removed favorite: \(diff.document.data()["FavoriteUserId"] ?? "")")
//                       for userId in self.favoriteUserIds{
//                           if userId == diff.document.data()["FavoriteUserId"] as! String{
//                               if let index = self.favoriteUserIds.firstIndex(of: userId) {
//                                   print("\(self.favoriteUserIds[index])を削除しました")
//                                   self.favoriteUserIds.remove(at: index)
//                               }
//                           }
//                       }
//                   }
//
//               }
//       }
//   }



//                ScrollView{
//                                        VStack{
//                                            ForEach(self.shareData.allUsers){ user in
//
//                //                                NavigationLink(destination: UserProfileView(user: user)) {
//                                                VStack{
//                                                    FirebaseImageView(imageURL: user.photoURL)
//                                                    HStack{
//                                                        Text("\(user.gender)") //テスト
//                                                        Text(user.age)
//                                                        Text(user.hometown)
//                                                    }
//                                                    Text(user.introduction)
//                                                    //
//                                                }
//                                                .onTapGesture {
//                                                    self.userInfo = user
//                                                    self.userProfileOn = true
//                                                }
//                //                                } //navigationlink
//                //                                    .buttonStyle(PlainButtonStyle())
//
//                                            } //foreach
//                                            .buttonStyle(PlainButtonStyle())
//
//                                        }//Vstack
//
//
//                                            .onAppear{
//                                                DispatchQueue.global().sync {
//                                                    self.shareData.getCurrentUser() //ログイン中のユーザー情報を取得し、そのあと全表示ユーザー情報取得
//                                                    print("リストビュー")
//                                                }
//                                        }
//                                        .onDisappear(){
//                                            //                            self.allUsers = [User]()
//                                        }
//
//                                    }//Scrollview



///
////  FavoriteView.swift
////  UserRegistration
////
////  Created by Yuki Shinohara on 2020/04/17.
////  Copyright © 2020 Yuki Shinohara. All rights reserved.
//
//import SwiftUI
//import FirebaseFirestore
//
//struct FavoriteView: View {
//
////    let db = Firestore.firestore()
//    @EnvironmentObject var shareData: ShareData
//
////    @State var favoriteUserIds = [String]()
//
//    @State var favoriteProfileOn = false
//
//
//    var body: some View {
//
//                VStack{
//
//                    ForEach(self.shareData.favoriteUsers, id: \.self){ user in
//                        Text(user.name)
//                    }
//
//            }
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .onAppear{
//            self.shareData.favoriteUserIds = [String]()
////            self.shareData.getFavoriteUsers()
//
//        }
////        .onDisappear{
//////            self.shareData.favoriteUserIds = [String]()
////        }
//    }
//}




//U SERRWINDE ww
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

