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
    
    @State var selectedSchedule = 0
    @State var selectedFee = 2
    @State var selectedPlaces = 0
    
    @State var selectedWork = 5
    @State var selectedStudyStyle = 0
    @State var selectedPurpose = 2
    
    @State var imageURL = ""
    @State var shown = false
    
    @Environment(\.presentationMode) var presentation
    
    @State var showingAlert = false
    
    var allSectionsFilled: Bool{
        return !email.isEmpty && !password.isEmpty && !name.isEmpty && !subject.isEmpty && !hobby.isEmpty && !introduction.isEmpty
    }
    
    @State var selection: Int? = nil
    @State var visible = false
    
    var body: some View {
        
        NavigationView {    // Formで使う場合はNavigationViewが必須
            GeometryReader{ geometry in
                ZStack{
                    Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255).edgesIgnoringSafeArea(.all)
                    
                    ScrollView(showsIndicators: false){
                        VStack{
                            Text("基本情報").foregroundColor(self.shareData.black).font(.headline).fontWeight(.bold).padding(.top)
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
                                    VStack{
                                    if self.visible{
                                         TextField("password", text: self.$password)
                                    } else {
                                         SecureField("password", text: self.$password)
                                        }
                                    }
                                        .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                        .disableAutocorrection(true)
                                        .padding().keyboardType(.emailAddress)
                                    
                                    Button(action: {
                                        self.visible.toggle()
                                    }) {
                                        Text(self.visible ? "非表示にする" : "表示する").foregroundColor(Color.gray).font(.subheadline)
                                    }.padding(.bottom)
                                }
                                
                                VStack{
                                    Text("あなたの名前").foregroundColor(self.shareData.brown)
                                    TextField("name", text: self.$name)
                                        .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                        .disableAutocorrection(true)
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
                                    Text("あなたの年齢").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedAge, label: Text("年齢")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.ages.count){ index in
                                                Text(self.shareData.ages[index]).tag(index)
                                            }
                                    }.labelsHidden()
                                }
                                
                                VStack{
                                    Text("あなたの現住所").foregroundColor(self.shareData.brown)
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
                                    TextField("hobby", text: self.$hobby)
                                        .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                        .disableAutocorrection(true)
                                        .padding()
                                    
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
                                    Text("自己紹介").foregroundColor(self.shareData.brown)
                                    TextField("comment", text: self.$introduction)
                                        .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                        .disableAutocorrection(true)
                                        .padding()
                                }
                                
                            }
                            Text("すたでいと").foregroundColor(self.shareData.black).font(.headline).fontWeight(.bold).padding(.top)
//                            HStack(alignment: .firstTextBaseline){
                                           Text("勉強したい、日中、カフェを選ぶと「すたでいとユーザー」になれます").foregroundColor(.yellow).font(.subheadline).fontWeight(.bold).frame(width: geometry.size.width * 0.7).padding(.top)
//                            }
                            Section{
                                VStack{
                                    Text("あなたが今勉強していること").foregroundColor(self.shareData.brown)
                                    TextField("subject", text: self.$subject)
                                        .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                        .disableAutocorrection(true)
                                        .padding()
                                }.padding(.top)
                                
                                VStack{
                                    Text("希望するすたでいと").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedStudyStyle, label: Text("デートスタイル")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.studystyles.count){ index in
                                                Text(self.shareData.studystyles[index]).tag(index).font(.subheadline)
                                            }
                                    }.labelsHidden()
                                    //                                MultilineTextView(text: self.$introduction).frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.1).font(.body).background(Color(red: 250 / 255, green: 250 / 255, blue: 250 / 255)).cornerRadius(10).padding()
                                }
                                
                                VStack{
                                    Text("希望する時間帯").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedSchedule, label: Text("")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.schedules.count){ index in
                                                Text(self.shareData.schedules[index]).tag(index).font(.subheadline)
                                            }
                                    }.labelsHidden()
                                    
                                }
                                
                                VStack{
                                    Text("希望する場所").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedPlaces, label: Text("")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.places.count){ index in
                                                Text(self.shareData.places[index]).tag(index).font(.subheadline)
                                            }
                                    }.labelsHidden()
                                    
                                }
                                
                                VStack{
                                    Text("デート代").foregroundColor(self.shareData.brown)
                                    Picker(selection: self.$selectedFee, label: Text("")
                                        .font(.title)
                                        .padding(.leading)) {
                                            ForEach(0..<self.shareData.fee.count){ index in
                                                Text(self.shareData.fee[index]).tag(index).font(.subheadline)
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
                            
                            
                            
                        }
                        
                        
                        NavigationLink(destination: PictureUploadView(email: self.email, password: self.password, name: self.name, age: self.shareData.ages[self.selectedAge], gender: self.genders[self.selectedGender], hometown: self.shareData.hometowns[self.selectedHometown], subject: self.subject, introduction: self.introduction, studystyle: self.shareData.studystyles[self.selectedStudyStyle], hobby: self.hobby, personality: self.shareData.personalities[self.selectedPersonality], job: self.shareData.jobs[self.selectedWork], purpose: self.shareData.purposes[self.selectedPurpose], place: self.shareData.places[self.selectedPlaces], schedule: self.shareData.schedules[self.selectedSchedule], fee: self.shareData.fee[self.selectedFee], pre: self.presentation).environmentObject(self.shareData), tag: 1, selection: self.$selection){
                            //                            https://stackoverflow.com/questions/57799548/navigationview-and-navigation-link-on-button-click-swift-ui
                            Button(action: {
                                if !self.allSectionsFilled {
                                    self.showingAlert = true
                                    return
                                }
                                print("navigation occured!")
                                self.selection = 1
                            }) {
                                Text("写真を追加")
                                    .padding()
                                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05)
                            }
                                
                            .foregroundColor(self.shareData.white)
                            .background(self.allSectionsFilled ? self.shareData.pink : Color(red: 220/255, green: 220/255, blue: 220/255)).cornerRadius(10)
                            .shadow(radius: 2, y:2)
                            .padding(.bottom)
                            //
                        }
                    }
                    .alert(isPresented: self.$showingAlert) {
                        Alert(title: Text("エラー"),
                              message: Text("未入力の項目があります。"))
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




//struct ContentView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        RegisterView()
//    }
//}
