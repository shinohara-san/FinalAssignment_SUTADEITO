//
//  ProfileEditView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/22.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject var shareData: ShareData
    
    
    @State var name:String = ""
    @State var subject:String = ""
    @State var hometown:String = ""
    @State var hobby:String = ""
    @State var introduction:String = ""
    @State var personality:String = ""
    @State var studystyle:String = ""
    @State var work:String = ""
    @State var purpose = ""
    
    @State var selectedHometown = 12
    @State var selectedWork = 0
    @State var selectedPersonality = 0
    @State var selectedPurpose = 0
    var datas: FirebaseData
//    func getUser() {
//        datas.listen()
//    }
    
    var body: some View {
        
            VStack{
                ScrollView{
                TextField("名前", text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                TextField("勉強中のもの", text: $subject).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                Picker(selection: $selectedHometown, label: Text("居住地")
                    .font(.title)
                    .padding(.leading)) {
                        ForEach(0..<self.shareData.hometowns.count){ index in
                            Text(self.shareData.hometowns[index]).tag(index)
                        }
                }
               
                TextField("趣味", text: $hobby).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                TextField("自己紹介", text: $introduction).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                Picker(selection: $selectedPersonality, label: Text("性格")
                    .font(.title)
                    .padding(.leading)) {
                        ForEach(0..<self.shareData.personalities.count){ index in
                            Text(self.shareData.personalities[index]).tag(index)
                        }
                }
                TextField("勉強方法", text: $studystyle).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                Picker(selection: $selectedWork, label: Text("職業")
                    .font(.title)
                    .padding(.leading)) {
                        ForEach(0..<self.shareData.jobs.count){ index in
                            Text(self.shareData.jobs[index]).tag(index)
                        }
                }
                Picker(selection: $selectedPurpose, label: Text("目的")
                    .font(.title)
                    .padding(.leading)) {
                        ForEach(0..<self.shareData.purposes.count){ index in
                            Text(self.shareData.purposes[index]).tag(index)
                        }
                }
                
                Section{
                    Button("戻る"){
                        self.shareData.editOn = false
                    }
                    
                    Button("保存する"){
                        self.shareData.saveEditInfo(name: self.name, subject: self.subject, hometown: self.shareData.hometowns[self.selectedHometown], hobby: self.hobby, introduction: self.introduction, personality: self.shareData.personalities[self.selectedPersonality], studystyle: self.studystyle, work: self.work, purpose: self.shareData.purposes[self.selectedPurpose])
                        self.shareData.getCurrentUser() //編集後のログインしているユーザーのデータを入れ直す
                        self.shareData.editOn = false
                    }
                    
                    Button(action: {
                        //アラート出したいなー
                        self.shareData.deleteAccount() //Auth削除 内部でstorage/firestoreも

                        self.shareData.currentUserData = [String : Any]()
                        self.datas.session = nil
                        
//                        firestoreのliketableやfavoritetableも空っぽに？
                        
                    }){
                        Text("退会する")
                    }
                }
                
            }//scroll view

        } //vstack
            .onAppear {
            // ここで初期値を代入
            self.name = self.shareData.currentUserData["name"] as! String
            self.subject = self.shareData.currentUserData["subject"] as! String
            self.hometown = self.shareData.currentUserData["hometown"] as! String
            self.hobby = self.shareData.currentUserData["hobby"] as! String
            self.introduction = self.shareData.currentUserData["introduction"] as! String
            self.personality = self.shareData.currentUserData["personality"] as! String
            self.studystyle = self.shareData.currentUserData["studystyle"] as! String
            self.work = self.shareData.currentUserData["work"] as! String
            self.purpose = self.shareData.currentUserData["purpose"] as! String
            self.getIndex()
//            self.shareData.deleteUserPicture() //テスト 消えた！
        }
        .onDisappear{
            self.shareData.editOn = false
        }
    }
    func getIndex() {
        let hometownIndex = shareData.hometowns.firstIndex(of: self.hometown)
        let personalityIndex = shareData.personalities.firstIndex(of: self.personality)
        let workIndex = shareData.jobs.firstIndex(of: self.work)
        let purposeIndex = shareData.purposes.firstIndex(of: self.purpose)
        
        if let hometownIndex = hometownIndex, let personalityIndex = personalityIndex, let workIndex = workIndex, let purposeIndex = purposeIndex{
            selectedHometown = hometownIndex
            selectedPurpose = purposeIndex
            selectedWork = workIndex
            selectedPersonality = personalityIndex
//            print(selectedHometown)
        }
    }
    
}

//struct ProfileEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileEditView()
//    }
//}
