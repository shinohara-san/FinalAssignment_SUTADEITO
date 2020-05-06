//
//  LoginView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/16.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.


import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @ObservedObject private var datas = firebaseData
    @EnvironmentObject var shareData: ShareData
    
    let messages = ["このアプリでは、\n「日中」に「カフェ」で\n「一緒に勉強する」\nという最初のデートを推奨しています。", "時間のかかるやり取りはなるべく短くし、会って、相手の空気感を感じてみてください。" , "お互いに勉強していれば会話が苦手でも大丈夫。「勉強」ですべての出会いが有意義なものになる。", "そんな真面目で安心な出会いを応援します。"]
    @State var index = 0
    
    @State var x: CGFloat = 0
    @State var count: CGFloat = 0
    @State var screen = UIScreen.main.bounds.width
    
    @Environment(\.presentationMode) var presentation
    
    func getMid()->Int{
        return shareData.pictures.count/2
    }
    
    func getUser() {
        datas.listen()
    }
    
    var body: some View {
        
        Group {
            if datas.session != nil {
                
                MainView(self.datas)
                    .navigationBarBackButtonHidden(true)
                    .onAppear(perform: getUser)
                
            } else {
                
                NavigationView {
                    GeometryReader{ geometry in
                    ZStack{
                        Color.gray.edgesIgnoringSafeArea(.all)
                        
                            ScrollView(.horizontal, showsIndicators: true){
                                HStack(spacing: 0) {
                                    ForEach(0 ..< self.shareData.pictures.count) { index in
                                        cardView(img: self.shareData.pictures[index], width: geometry.size.width, height: geometry.size.height)
                                            .environmentObject(self.shareData)
                                            .offset(x: self.x)
                                            .highPriorityGesture(DragGesture()
                                                .onChanged({ (value) in
                                                    
                                                    if value.translation.width > 0 {
                                                        self.x = value.location.x
                                                    } else {
                                                        self.x = value.location.x - self.screen
                                                    }
                                                    
                                                })
                                                .onEnded({ (value) in
                                                    if value.translation.width > 0{
                                                        if value.translation.width > ((self.screen - 80)/2) && Int(self.count) != self.getMid(){
                                                            self.count += 1
                                                            self.x = (self.screen) * self.count
                                                        } else {
                                                            self.x = (self.screen) * self.count
                                                        }
                                                    }else{
                                                        if -value.translation.width > ((self.screen - 80)/2) && -Int(self.count) != self.getMid(){
                                                            self.count -= 1
                                                            self.x = (self.screen) * self.count
                                                        } else {
                                                            self.x = (self.screen) * self.count
                                                        }
                                                    }
                                                    
                                                })
                                        )
                                        
                                        //
                                    }
                                }
                            }
                        
                        VStack{
                            Spacer()
                            TextField("email", text: self.$email)
                                .disableAutocorrection(true)
                                .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                
                                .keyboardType(.emailAddress)
                                .padding(.bottom)
                            SecureField("password", text: self.$password)
                                .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                
                                .keyboardType(.emailAddress)
                                .padding(.bottom)
                            
                            Button(action: {
                                if self.email == "" || self.password == ""{
                                    return
                                }
                                self.datas.logIn(email: self.email, password: self.password) { (res, err) in
                                    if err != nil {
                                        print("Error: ログイン")
                                        
                                    } else {
                                        self.email = ""
                                        self.password = ""
                     
                                    }
                                }
                            }) {
                                Text("ログイン").foregroundColor(self.shareData.white)
                                    .padding()
                                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05)
                                .background(self.shareData.pink).cornerRadius(10)
                                .shadow(radius: 2, y:2)
                            }.padding(.bottom, 50)
                            
                            Button(action: {
                                self.presentation.wrappedValue.dismiss()
                            }, label: {
                                Text("戻る").foregroundColor(self.shareData.white).underline(color: self.shareData.white)
                            }).padding(.bottom, 50)
                            
                            Spacer()
                            
                        }.onAppear(perform: self.getUser)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .padding(.top, 80)
                        
                        }
                    }
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
            }
            
        }
        
        }
    
    }
    
    
    public struct CustomTextFieldStyle : TextFieldStyle {
        var geometry: GeometryProxy
        public func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(10)
                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05, alignment: .center)
                .background(Color(red: 248 / 255, green: 248 / 255, blue: 248 / 255))
            .cornerRadius(10)
            
                //Give it some style
//                .background(
//                    RoundedRectangle(cornerRadius: 10))
//                        .strokeBorder(Color.primary.opacity(0.5), lineWidth: 3))
        }
    }

    
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
}
