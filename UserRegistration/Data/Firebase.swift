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
    func createData(_ email:String, _ name:String, _ age:String, _ gender:String, _ hometown:String, _ subject:String, _ introduction:String, _ studystyle:String, _ hobby:String, _ personality:String, _ work:String, _ purpose:String, _ photoURL: String, _ fee:String, _ place:String, _ schedule: String) {
            // To create or overwrite a single documentbbb@bbb.com
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
                "photoURL": photoURL,
                "fee" : fee,
                "place": place,
                "schedule" : schedule
                
            ]) { (err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }else {
                    print("createData success")
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
    
    


