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
    @State var fee = ""
    @State var place = ""
    @State var schedule = ""
    
    @State var selectedStudyStyle = 0
    @State var selectedFee = 0
    @State var selectedPlace = 0
    @State var selectedSchedule = 0
    @State var selectedAge = 10
    @State var selectedHometown = 12
    @State var selectedWork = 0
    @State var selectedPersonality = 0
    @State var selectedPurpose = 0
    var datas: FirebaseData
    
    @State var confirmDelete = false
    
    @State var proceedToDelete = false
    
    
    var body: some View {
        GeometryReader{ geo in
            NavigationView{
                ZStack{
                    self.shareData.white.edgesIgnoringSafeArea(.all)
                    VStack{
                        ScrollView(showsIndicators: false){
                            VStack{
                                Text("名前").foregroundColor(self.shareData.brown)
                                TextField("name", text: self.$name).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                            }.padding(.top)
                            VStack{
                                Text("年齢").foregroundColor(self.shareData.brown)
                                Picker(selection: self.$selectedAge, label: Text("age")
                                    .font(.title)
                                    .padding(.leading)) {
                                        ForEach(0..<self.shareData.ages.count){ index in
                                            Text(self.shareData.ages[index]).tag(index)
                                        }
                                }.labelsHidden()
                                VStack{
                                    Text("現住所").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedHometown, label: Text("current city")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.hometowns.count){ index in
                                                Text(self.shareData.hometowns[index]).tag(index)
                                            }
                                    }.labelsHidden()
                                }
                                VStack{
                                    Text("趣味").foregroundColor(self.shareData.brown)
                                    TextField("hobby", text: self.$hobby).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                                }
                                
                                VStack{
                                    Text("職業").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedWork, label: Text("職業")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.jobs.count){ index in
                                                Text(self.shareData.jobs[index]).tag(index)
                                            }
                                    }.labelsHidden()
                                }
                                
                                VStack{
                                    Text("性格").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedPersonality, label: Text("性格")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.personalities.count){ index in
                                                Text(self.shareData.personalities[index]).tag(index)
                                            }
                                    }.labelsHidden()
                                }
                                
                                VStack{
                                    Text("自己紹介").foregroundColor(self.shareData.brown)
                                    TextField("comment", text: self.$introduction).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                                }
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            Section{
                                VStack{
                                    Text("勉強中").foregroundColor(self.shareData.brown)
                                    TextField("subject", text: self.$subject).textFieldStyle(CustomTextFieldStyle(geometry: geo)).padding()
                                }
                                
                                VStack{
                                    Text("希望するすたでいと").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedStudyStyle, label: Text("")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.studystyles.count){ index in
                                                Text(self.shareData.studystyles[index]).tag(index).font(.subheadline)
                                            }
                                    }.labelsHidden()
                                }
                                
                                VStack{
                                    Text("希望する時間帯").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedSchedule, label: Text("")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.schedules.count){ index in
                                                Text(self.shareData.schedules[index]).tag(index)
                                            }
                                    }.labelsHidden()
                                }
                                
                                VStack{
                                    Text("希望する場所").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedPlace, label: Text("")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.places.count){ index in
                                                Text(self.shareData.places[index]).tag(index)
                                            }
                                    }.labelsHidden()
                                }
                                
                                VStack{
                                    Text("デート代").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedFee, label: Text("")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.fee.count){ index in
                                                Text(self.shareData.fee[index]).tag(index)
                                            }
                                    }.labelsHidden()
                                }
                                VStack{
                                    Text("目的").foregroundColor(self.shareData.brown)
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
                                
                                Button(action: {
                                    self.presentation.wrappedValue.dismiss()
                                }) {
                                    Text("戻る")
                                        .textStyle(fcolor: self.shareData.white, bgcolor: self.shareData.brown, geometry: geo)
                                }
                                .padding(.bottom)
                                
                                Button(action: {
                                    self.shareData.saveEditInfo(name: self.name, age: self.shareData.ages[self.selectedAge], subject: self.subject, hometown: self.shareData.hometowns[self.selectedHometown], hobby: self.hobby, introduction: self.introduction, personality: self.shareData.personalities[self.selectedPersonality], studystyle: self.shareData.studystyles[self.selectedStudyStyle], work: self.shareData.jobs[self.selectedWork], purpose: self.shareData.purposes[self.selectedPurpose], fee: self.shareData.fee[self.selectedFee], place: self.shareData.places[self.selectedPlace], schedule: self.shareData.schedules[self.selectedSchedule])
                                    //編集後のログインしているユーザーのデータを入れ直す
                                    //                        self.shareData.editOn = false
                                    self.presentation.wrappedValue.dismiss()
                                }) {
                                    Text("保存する")
                                        .textStyle(fcolor: self.shareData.white, bgcolor: self.shareData.pink, geometry: geo)
                                        .padding(.bottom)
                                }
                                
                                Button(action: {
                                    self.confirmDelete = true
                                }){
                                    Text("退会する").foregroundColor(Color.gray)
                                }.padding(.bottom)
                            }
                        } ///退会処理の変更→押すと退会ページに進みますのアラート,
                        ///押すと再ログイン→最終確認→退会
                        ///再ログインさせるもしくはその画面を作る。ログインし直させると一発退会できる。]
                        //
                    }//scroll view
                }
                .actionSheet(isPresented: self.$confirmDelete) {
                    ActionSheet(title: Text("退会処理に進みますか？"), message: Text("一度ログアウトします。"), buttons: [.default(Text("戻る"), action:{}),.destructive(Text("進む"), action:{
                        self.datas.logOut()
                        //self.datas.session = nil
                        self.proceedToDelete = true
                        
                    })
                        ]
                    )
                }.sheet(isPresented: self.$proceedToDelete) {
                    BridgeToDeleteView().environmentObject(self.shareData)
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
                self.fee = self.shareData.currentUserData["fee"] as! String
                self.schedule = self.shareData.currentUserData["schedule"] as! String
                self.place = self.shareData.currentUserData["place"] as! String
                
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
        let styleIndex = shareData.studystyles.firstIndex(of: self.studystyle)
        let feeIndex = shareData.fee.firstIndex(of: self.fee)
        let scheduleIndex = shareData.schedules.firstIndex(of: self.schedule)
        let placeIndex = shareData.places.firstIndex(of: self.place)
        
        if let hometownIndex = hometownIndex, let personalityIndex = personalityIndex, let workIndex = workIndex, let purposeIndex = purposeIndex, let ageIndex = ageIndex, let styleIndex = styleIndex, let feeIndex = feeIndex, let scheduleIndex = scheduleIndex, let placeIndex = placeIndex{
            selectedAge = ageIndex
            selectedHometown = hometownIndex
            selectedPurpose = purposeIndex
            selectedWork = workIndex
            selectedPersonality = personalityIndex
            selectedStudyStyle = styleIndex
            selectedFee = feeIndex
            selectedSchedule = scheduleIndex
            selectedPlace = placeIndex
        }
    }
    
}

//struct ProfileEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileEditView()
//    }
//}


