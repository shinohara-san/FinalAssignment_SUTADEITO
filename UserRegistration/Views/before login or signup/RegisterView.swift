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
    @State var email = ""
    @State var password = ""
    @State var name = ""
    let genders = ["女性", "男性"]
    @State var selectedGender = 0
    var ages = [Int]()
    @State var age:Double = 25
    let hometowns = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県",
    "茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県",
    "新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県",
    "静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県",
    "奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県",
    "徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県",
    "熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    @State var selectedHometown = 12
    @State var subject = ""
    @State var introduction = ""
    @State var studystyle = ""
    @State var hobby = ""
    @State var selectedPersonality = 2
    let personalities = ["おっとり", "社交的", "元気", "物静か", "その他"]
    @State var selectedWork = 1
    let jobs = ["会社員", "教師", "医者", "公務員","フリーター", "学生", "その他"]
    @State var selectedPurpose = 2
    let purposes  = ["勉強", "出会い", "婚活", "その他"]
    
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
                        
                        Text("年齢: \(self.age, specifier: "%g")歳")
                        
                        Slider(value: $age, in: 18...45, step: 1.0).padding(.horizontal)

                        Picker(selection: $selectedHometown, label: Text("居住地")
                            .font(.title)
                            .padding(.leading)) {
                                ForEach(0..<hometowns.count){ index in
                                    Text(self.hometowns[index]).tag(index)
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
                                ForEach(0..<personalities.count){ index in
                                    Text(self.personalities[index]).tag(index)
                                }
                        }
                        //                }
                        
                        Picker(selection: $selectedWork, label: Text("仕事")
                            .font(.title)
                            .padding(.leading)) {
                                ForEach(0..<jobs.count){ index in
                                    Text(self.jobs[index]).tag(index)
                                }
                        }
                        Picker(selection: $selectedPurpose, label: Text("目的")
                            .font(.title)
                            .padding(.leading)) {
                                ForEach(0..<purposes.count){ index in
                                    Text(self.purposes[index]).tag(index)
                                }
                        }
                    }
                    
                    NavigationLink(destination: PictureUploadView(email: self.email, password: self.password, name: self.name, age: Int(self.age), gender: self.genders[selectedGender], hometown: self.hometowns[selectedHometown], subject: self.subject, introduction: self.introduction, studystyle: self.studystyle, hobby: self.hobby, personality: self.personalities[selectedPersonality], job: self.jobs[selectedWork], purpose: self.purposes[selectedPurpose])){
                          Text("写真を追加")
                    }
                }
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
