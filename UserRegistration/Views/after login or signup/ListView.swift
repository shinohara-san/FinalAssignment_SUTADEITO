//
//  ListView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct ListView: View {
    var datas: FirebaseData
    //    var currentUser : [String : Any]
    @State var allUsers : [User] = [User(id: "", email: "", name: "", gender: "", age: 0, hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")] //ScrollViewには最初に配列に初期値を設定する必要あり
    
    @EnvironmentObject var shareData: ShareData
    //    @ObservedObject var session: User
    let db = Firestore.firestore()
    func getCurrentUser() {
        db.collection("Users").whereField("email", isEqualTo: datas.session!.email!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.shareData.currentUserData = document.data()
                    //                        print(self.shareData.currentUserData)
                    //                        self.currentUser = document.data()
                    //                        print(self.currentUser["subject"] ?? "")
                    //                            print("ゲットカレントビュー")
                    self.getAllUsers()
                }
            }
        }
        
        //        self.getAllUsers()
    }
    
    func getAllUsers(){
        allUsers = [User]()
        let dbCollection = Firestore.firestore().collection("Users")
        //        .whereField("gender", isEqualTo: chosenGender).
        dbCollection.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for user in querySnapshot!.documents {
                    //                    print(user.data())shareData.currentUserData["email"]
                    //                    User型に直してappend
                    //                    if user.data()["email"] as? String != self.datas.session?.email{
                    if user.data()["gender"] as? String !=    self.shareData.currentUserData["gender"] as? String{
                        //                        self.datas.session?.email
                        
                        self.allUsers.append(User(
                            id: user.data()["id"] as! String,
                            email: user.data()["email"] as! String,
                            name: user.data()["name"] as! String,
                            gender: user.data()["gender"] as! String,
                            age: user.data()["age"] as! Int,
                            hometown: user.data()["hometown"] as! String,
                            subject: user.data()["subject"] as! String,
                            introduction: user.data()["introduction"] as! String,
                            studystyle: user.data()["studystyle"] as! String,
                            hobby: user.data()["hobby"] as! String,
                            personality: user.data()["personality"] as! String,
                            work: user.data()["work"] as! String,
                            purpose: user.data()["purpose"] as! String,
                            photoURL: user.data()["photoURL"] as! String
                        ))
                        
                    }

                }
            }
        }
    }
    
    var body: some View {
        
 ScrollView{
        VStack{
            ForEach(self.allUsers){ user in
                
                NavigationLink(destination: UserProfileView(user: user)) {
                    FirebaseImageView(imageURL: user.photoURL)
                    HStack{
                        Text("\(user.gender)") //テスト
                        Text("\(user.age)歳")
                        Text(user.hometown)
                    }
                    Text(user.introduction)
                }
                .buttonStyle(PlainButtonStyle())
            } //foreach
        } //vstack
 }//scrollview
            .onAppear{
                DispatchQueue.global().sync {
                    self.getCurrentUser()
                }
                print("リストビュー")
        }
        .onDisappear(){
            self.allUsers = [User]()
        }
        .navigationBarTitle("")
        .navigationBarHidden(false)
        
    } //body
    
} //全体

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView()
//    }
//}
