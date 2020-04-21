//
//  Firebase.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/15.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth


let dbCollection = Firestore.firestore().collection("Users")
let firebaseData = FirebaseData()

class FirebaseData: ObservableObject{
    
    @Published var session: FirebaseAuth.User?
    
    func listen() {
        //        ユーザーのログイン状態が変わるたびに呼び出される
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            //            ユーザーがいたら
            if let user = user {
//                print(user.email)
                self.session = user
            } else {
                //  ユーザーがいなかったら
                self.session = nil
            }
        }
    }

//
//        // Reference link: https://firebase.google.com/docs/firestore/manage-data/add-data
    func createData(_ email:String, _ name:String, _ age:String, _ gender:String, _ hometown:String, _ subject:String, _ introduction:String, _ studystyle:String, _ hobby:String, _ personality:String, _ work:String, _ purpose:String, _ photoURL: String) {
            // To create or overwrite a single document
            dbCollection.document().setData([
                "id" : dbCollection.document().documentID,
                "email": email,
                "name": name,
                "age": age,
                "gender": gender,
                "hometown": hometown,
                "subject": subject,
                "introduction": introduction,
                "studystyle": studystyle,
                "hobby": hobby,
                "personality": personality,
                "work": work,
                "purpose": purpose,
//                "uid": Auth.auth().currentUser?.uid ?? ""
                "photoURL": photoURL
                
            ]) { (err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }else {
                    print("createData(Firebase.swift) success")
                }
            }
        }

    func signUp(_ email: String, _ password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func logIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func logOut() {
                try! Auth.auth().signOut()
                self.session = nil

        }
}

    
        // Reference link : https://firebase.google.com/docs/firestore/query-data/listen
//        func readData() {
//            dbCollection.addSnapshotListener { (documentSnapshot, err) in
//                if err != nil {
//                    print((err?.localizedDescription)!)
//                    return
//                }else {
//                    print("read data success")
//                }
//
//                documentSnapshot!.documentChanges.forEach { diff in
//                    if (diff.type == .added) {
//    //                    データ新規追加だったら、ThreadDataType型のデータを生成(idはdbから、msgはtestTextという名前のデータを取得)し、それをdata配列に追加　→                        表示更新
//                        let userData = User(id: diff.document.documentID,
//                                            name: diff.document.get("name") as! String,
//                                            age: diff.document.get("age") as! Int,
//                                            hometown: diff.document.get("hometown") as! String,
//                                            subject: diff.document.get("subject") as! String,
//                                            introduction: diff.document.get("introduction") as! String,
//                                            studystyle: diff.document.get("studystyle") as! String,
//                                            hobby: diff.document.get("hobby") as! String,
//                                            personality: diff.document.get("personality") as! String,
//                                            work: diff.document.get("work") as! String,
//                                            purpose: diff.document.get("purpose") as! String)
//                        self.data.append(userData)
//                    }
//    //                既存データ更新だったら、それぞれのデータをThredDataTypeでリターン
//    //                表示されているデータのidとdb上のデータのidが一緒なら
//    //                表示されているデータのmsgを同じidを持ったデータのtestTextに書き換え
//    //                同じidじゃないやつはそのまま返す
//
//                    if (diff.type == .modified) {
//                        self.data = self.data.map { (eachData) -> User in
//                            var data = eachData
//                            if data.id == diff.document.documentID {
//                                data.name = diff.document.get("name") as! String
//                                return data
//                            }else {
//                                return eachData
//                            }
//                        }
//                    }
//                }
//            }
//        }

//        //Reference link: https://firebase.google.com/docs/firestore/manage-data/delete-data
//        func deleteData(datas: FirebaseData ,index: IndexSet) {
//    //        dbから削除
//            let id = datas.data[index.first!].id
//            dbCollection.document(id).delete { (err) in
//
//                if err != nil {
//                    print((err?.localizedDescription)!)
//                    return
//                }else {
//                    print("delete data success")
//                }
//    //            表示されてる
//    //            datas.data.remove(atOffsets:index)
//                self.data.remove(atOffsets:index)
//            }
//        }
//
//        // Reference link: https://firebase.google.com/docs/firestore/manage-data/add-data
//        func updateData(id: String, txt: String) {
//            dbCollection.document(id).updateData(["testText":txt]) { (err) in
//                if err != nil {
//                    print((err?.localizedDescription)!)
//                    return
//                }else {
//                    print("update data success")
//                }
//            }
//        }
    
    


