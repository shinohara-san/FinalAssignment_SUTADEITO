//
//  ContentView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/15.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var shareData : ShareData
    
    @State var email = ""
    @State var password = ""
    @State var name = ""
    let genders = ["女性", "男性"]
    @State var selectedGender = 0
    
    @State var selectedAge = 10
    
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
    
    @Environment(\.presentationMode) var presentation
    
    @State var showingAlert = false
    
    var body: some View {
        
        NavigationView {    // Formで使う場合はNavigationViewが必須
            GeometryReader{ geometry in
                ZStack{
                    Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255).edgesIgnoringSafeArea(.all)
                    
                    ScrollView(showsIndicators: false){
                        VStack{
                            Section{
                                VStack{
                                    Text("あなたのEメールアドレス").foregroundColor(self.shareData.brown)
                                    Text("※ログイン時に使用します。").foregroundColor(self.shareData.pink).font(.footnote)
                                    TextField("email", text: self.$email)
                                        .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                        .disableAutocorrection(true)
                                        .padding().keyboardType(.emailAddress)
                                }.padding(.top)
                                
                                VStack{
                                    Text("あなたのパスワード").foregroundColor(self.shareData.brown)
                                    Text("※ログイン時に使用します。").foregroundColor(self.shareData.pink).font(.footnote)
                                    SecureField("password", text: self.$password)
                                    .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                    .padding().keyboardType(.emailAddress)
                                }
                                
                                VStack{
                                Text("あなたのニックネーム").foregroundColor(self.shareData.brown)
                                    TextField("name", text: self.$name)
                                    .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                    .padding()
                                }
                                VStack{
                                    Text("あなたの性別").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedGender, label: Text("性別")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.genders.count){ index in
                                                Text(self.genders[index]).tag(index)
                                            }
                                    }.pickerStyle(SegmentedPickerStyle()).frame(width: geometry.size.width * 0.7)
                                    
                                }
                                VStack{
                                    Text("あなたが今勉強していること").foregroundColor(self.shareData.brown)
                                    TextField("subject", text: self.$subject)
                                    .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                    .padding()
                                }.padding(.top)
                                
                                VStack{
                                    Text("あなたの趣味").foregroundColor(self.shareData.brown)
                                    TextField("hobby", text: self.$hobby)
                                        .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                        .padding()
                                    
                                }
                                VStack{
                                    Text("あなたから一言").foregroundColor(self.shareData.brown)
                                    TextField("comment", text: self.$introduction)
                                    .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                    .padding()
                                }
                                
                                
                                VStack{
                                    Text("あなたの年齢").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedAge, label: Text("年齢")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.ages.count){ index in
                                                Text(self.shareData.ages[index]).tag(index)
                                            }
                                    }.labelsHidden()
                                }
                            }
                            
                            VStack{
                                 Text("希望するデート").foregroundColor(self.shareData.brown)
                                TextField("dating style", text: self.$studystyle)
                                    .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                    .padding()
                                //                                MultilineTextView(text: self.$introduction).frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.1).font(.body).background(Color(red: 250 / 255, green: 250 / 255, blue: 250 / 255)).cornerRadius(10).padding()
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
                                Text("あなたの性格").foregroundColor(self.shareData.brown)
                                Picker(selection: self.$selectedPersonality, label: Text("性格")
                                    .font(.title)
                                    .padding(.leading)) {
                                        ForEach(0..<self.shareData.personalities.count){ index in
                                            Text(self.shareData.personalities[index]).tag(index)
                                        }
                                }.labelsHidden()
                            }
                            
                            VStack{
                                Text("あなたの職業").foregroundColor(self.shareData.brown)
                                Picker(selection: self.$selectedWork, label: Text("仕事")
                                    .font(.title)
                                    .padding(.leading)) {
                                        ForEach(0..<self.shareData.jobs.count){ index in
                                            Text(self.shareData.jobs[index]).tag(index)
                                        }
                                }.labelsHidden()
                            }
                            
                            
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
                        
                        
                        
                        
                        
                        NavigationLink(destination: PictureUploadView(email: self.email, password: self.password, name: self.name, age: self.shareData.ages[self.selectedAge], gender: self.genders[self.selectedGender], hometown: self.shareData.hometowns[self.selectedHometown], subject: self.subject, introduction: self.introduction, studystyle: self.studystyle, hobby: self.hobby, personality: self.shareData.personalities[self.selectedPersonality], job: self.shareData.jobs[self.selectedWork], purpose: self.shareData.purposes[self.selectedPurpose], pre: self.presentation).environmentObject(self.shareData)){
                            
                            Button("写真を追加"){
                                if self.password == "" || self.email == "" || self.name == "" || self.subject == "" || self.introduction == "" || self.studystyle == "" || self.hobby == "" {
                                    self.showingAlert = true
                                }
                            }
                            .padding()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05)
                            .foregroundColor(self.shareData.white)
                            .background(self.shareData.pink).cornerRadius(10)
                            .padding(.bottom)
                        }.alert(isPresented: self.$showingAlert) {
                            Alert(title: Text("エラー"),
                                  message: Text("必要事項を入力してください。"))
                        }
                        
                    }
                }//zstack
                
            }
            .navigationBarTitle(Text("プロフィール作成"), displayMode: .inline)
            .navigationBarItems(leading: Button("戻る"){
                self.presentation.wrappedValue.dismiss()
            }.foregroundColor(self.shareData.white))
                .navigationBarBackButtonHidden(true)
        } //navigationview
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}




struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        RegisterView()
    }
}
