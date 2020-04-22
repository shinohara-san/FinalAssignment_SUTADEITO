//
//  ContentView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/15.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI
//import FirebaseStorage

struct RegisterView: View {
    @EnvironmentObject var shareData : ShareData
    
    @State var email = ""
    @State var password = ""
    @State var name = ""
    let genders = ["女性", "男性"]
    @State var selectedGender = 0
    @State var ages = ["20代", "30代", "40代"] //foreachで中身を作りたい
    @State var selectedAge = 0
    
    @State var selectedHometown = 12
    @State var subject = ""
    @State var introduction = ""
    @State var studystyle = ""
    @State var hobby = ""
    @State var selectedPersonality = 2
    
    @State var selectedWork = 1
    
    @State var selectedPurpose = 2
    
    
    @State var imageURL = ""
    @State var shown = false
    
    var body: some View {

        NavigationView {    // Formで使う場合はNavigationViewが必須
            ScrollView{
                VStack{
                    Section{
                        TextField("email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .padding().keyboardType(.emailAddress)
                        SecureField("password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding().keyboardType(.emailAddress)
                    }

                    
                    Section{
                        TextField("name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Picker(selection: $selectedGender, label: Text("性別")
                            .font(.title)
                            .padding(.leading)) {
                                ForEach(0..<genders.count){ index in
                                    Text(self.genders[index]).tag(index)
                                }
                        }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                        
                        Picker(selection: $selectedAge, label: Text("年齢")
                            .font(.title)
                            .padding(.leading)) {
                                ForEach(0..<ages.count){ index in
                                    Text(self.ages[index]).tag(index)
                                }
                        }
                        

                        Picker(selection: $selectedHometown, label: Text("居住地")
                            .font(.title)
                            .padding(.leading)) {
                                ForEach(0..<self.shareData.hometowns.count){ index in
                                    Text(self.shareData.hometowns[index]).tag(index)
                                }
                        }
                        TextField("subject", text: $subject)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        TextField("introduction", text: $introduction)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        TextField("studystyle", text: $studystyle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        TextField("hobby", text: $hobby)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                    //               Form { navigationviewとformで別ページでの設定できるはずなんだが
                    Section{
                        Picker(selection: $selectedPersonality, label: Text("性格")
                            .font(.title)
                            .padding(.leading)) {
                                ForEach(0..<self.shareData.personalities.count){ index in
                                    Text(self.shareData.personalities[index]).tag(index)
                                }
                        }
                        //                }
                        
                        Picker(selection: $selectedWork, label: Text("仕事")
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
                    }
                    
                    NavigationLink(destination: PictureUploadView(email: self.email, password: self.password, name: self.name, age: self.ages[selectedAge], gender: self.genders[selectedGender], hometown: self.shareData.hometowns[selectedHometown], subject: self.subject, introduction: self.introduction, studystyle: self.studystyle, hobby: self.hobby, personality: self.shareData.personalities[selectedPersonality], job: self.shareData.jobs[selectedWork], purpose: self.shareData.purposes[selectedPurpose])){
                          Text("写真を追加")
                    }
                }
            }
            .onAppear{
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)

        }
    }
    }




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
         RegisterView()
    }
}
