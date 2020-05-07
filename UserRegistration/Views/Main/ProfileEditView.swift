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
    @Environment(\.presentationMode) var presentation
    
    @State var name:String = ""
    @State var age: String = ""
    @State var subject:String = ""
    @State var hometown:String = ""
    @State var hobby:String = ""
    @State var introduction:String = ""
    @State var personality:String = ""
    @State var studystyle:String = ""
    @State var work:String = ""
    @State var purpose = ""
    
    @State var selectedAge = 10
    @State var selectedHometown = 12
    @State var selectedWork = 0
    @State var selectedPersonality = 0
    @State var selectedPurpose = 0
    var datas: FirebaseData
    
    @State var confirmDelete = false
    
    var body: some View {
        GeometryReader{ geo in
            NavigationView{
            ZStack{
                self.shareData.white.edgesIgnoringSafeArea(.all)
        VStack{
            ScrollView(showsIndicators: false){
                VStack{
                Text("あなたのニックネーム").foregroundColor(self.shareData.brown)
                TextField("name", text: self.$name).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                }.padding(.top)
                VStack{
                Text("あなたの年齢").foregroundColor(self.shareData.brown)
                Picker(selection: self.$selectedAge, label: Text("age")
                    .font(.title)
                    .padding(.leading)) {
                        ForEach(0..<self.shareData.ages.count){ index in
                            Text(self.shareData.ages[index]).tag(index)
                        }
                }.labelsHidden()
                }
                VStack{
                Text("あなたが今勉強していること").foregroundColor(self.shareData.brown)
                TextField("subject", text: self.$subject).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                }
                
                VStack{
                Text("あなたの居住地").foregroundColor(self.shareData.brown)
                Picker(selection: self.$selectedHometown, label: Text("current city")
                    .font(.title)
                    .padding(.leading)) {
                        ForEach(0..<self.shareData.hometowns.count){ index in
                            Text(self.shareData.hometowns[index]).tag(index)
                        }
                }.labelsHidden()
                }
                
                VStack{
                Text("あなたの趣味").foregroundColor(self.shareData.brown)
                TextField("hobby", text: self.$hobby).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                }
                
                VStack{
                Text("あなたから一言").foregroundColor(self.shareData.brown)
                TextField("comment", text: self.$introduction).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                }
                
                VStack{
                Text("あなたの性格").foregroundColor(self.shareData.brown)
                Picker(selection: self.$selectedPersonality, label: Text("性格")
                    .font(.title)
                    .padding(.leading)) {
                        ForEach(0..<self.shareData.personalities.count){ index in
                            Text(self.shareData.personalities[index]).tag(index)
                        }
                }.labelsHidden()
                }
                
                Section{
                    VStack{
                    Text("希望するデート").foregroundColor(self.shareData.brown)
                    TextField("dating style", text: self.$studystyle).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                    }
                    
                    VStack{
                    Text("あなたの職業").foregroundColor(self.shareData.brown)
                    Picker(selection: self.$selectedWork, label: Text("職業")
                        .font(.title)
                        .padding(.leading)) {
                            ForEach(0..<self.shareData.jobs.count){ index in
                                Text(self.shareData.jobs[index]).tag(index)
                            }
                    }.labelsHidden()
                    }
                    
                    VStack{
                    Text("このアプリを使う目的").foregroundColor(self.shareData.brown)
                    Picker(selection: self.$selectedPurpose, label: Text("目的")
                        .font(.title)
                        .padding(.leading)) {
                            ForEach(0..<self.shareData.purposes.count){ index in
                                Text(self.shareData.purposes[index]).tag(index)
                            }
                    }.labelsHidden()
                    }
                }
                
                
                Section{
                    Button("戻る"){
//                        self.shareData.editOn = false
                        self.presentation.wrappedValue.dismiss()
                    }
                    .foregroundColor(self.shareData.white)
                    .padding()
                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.05)
                    .background(self.shareData.brown)
                    .cornerRadius(10)
                    .shadow(radius: 2, y: 2)
                    .frame(width: geo.size.width * 1, height: geo.size.height * 0.05)
                    .padding(.bottom)
                    
                    Button("保存する"){
                        self.shareData.saveEditInfo(name: self.name, age: self.shareData.ages[self.selectedAge], subject: self.subject, hometown: self.shareData.hometowns[self.selectedHometown], hobby: self.hobby, introduction: self.introduction, personality: self.shareData.personalities[self.selectedPersonality], studystyle: self.studystyle, work: self.work, purpose: self.shareData.purposes[self.selectedPurpose])
                         //編集後のログインしているユーザーのデータを入れ直す
//                        self.shareData.editOn = false
                        self.presentation.wrappedValue.dismiss()
                        }
                        .padding()
                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.05)
                        .foregroundColor(self.shareData.white)
                    .background(self.shareData.pink).cornerRadius(10)
                    .shadow(radius: 2, y: 2)
                    .frame(width: geo.size.width * 1, height: geo.size.height * 0.05)
                    .padding(.bottom)
                    
                    Button(action: {
                        self.confirmDelete = true
                    }){
                        Text("退会する").foregroundColor(Color.gray)
                    }.padding(.bottom)
                }
            }.actionSheet(isPresented: self.$confirmDelete) {
                ActionSheet(title: Text("本当に退会しますか？"), message: Text("全てのデータやお相手とのメッセージが削除されます。\n※退会できない場合は再度ログインしてからお試しください。"), buttons: [ .default(Text("退会しない"), action:{}),                                    .destructive(Text("退会する"), action:{
                    self.shareData.deleteAccount() //Auth
                    self.shareData.deleteUserData() //Firestore
                    self.shareData.deleteUserPicture() //storage
                    self.datas.logOut()
                    self.presentation.wrappedValue.dismiss()
                    self.shareData.currentUserData = [String : Any]()
                })
                    ]
                )
            }
            }//scroll view
            }
            .navigationBarTitle(Text("プロフィール編集"), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "multiply").foregroundColor(self.shareData.white)
                })
                )
        }//navi
        } //geo
            .onAppear {
                // ここで初期値を代入
                self.name = self.shareData.currentUserData["name"] as! String
                self.age = self.shareData.currentUserData["age"] as! String
                self.subject = self.shareData.currentUserData["subject"] as! String
                self.hometown = self.shareData.currentUserData["hometown"] as! String
                self.hobby = self.shareData.currentUserData["hobby"] as! String
                self.introduction = self.shareData.currentUserData["introduction"] as! String
                self.personality = self.shareData.currentUserData["personality"] as! String
                self.studystyle = self.shareData.currentUserData["studystyle"] as! String
                self.work = self.shareData.currentUserData["work"] as! String
                self.purpose = self.shareData.currentUserData["purpose"] as! String
                
                self.getIndex()
                
        }
        .onDisappear{
//            self.shareData.editOn = false
//            self.shareData.getCurrentUser()bbb@bbb.com
        }
    }
    func getIndex() {
        let ageIndex = shareData.ages.firstIndex(of: self.age)
        let hometownIndex = shareData.hometowns.firstIndex(of: self.hometown)
        let personalityIndex = shareData.personalities.firstIndex(of: self.personality)
        let workIndex = shareData.jobs.firstIndex(of: self.work)
        let purposeIndex = shareData.purposes.firstIndex(of: self.purpose)
        
        if let hometownIndex = hometownIndex, let personalityIndex = personalityIndex, let workIndex = workIndex, let purposeIndex = purposeIndex, let ageIndex = ageIndex{
            selectedAge = ageIndex
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
