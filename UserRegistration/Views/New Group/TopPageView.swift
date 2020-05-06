//
//  TopPageView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/16.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct TopPageView: View {
    init() {
        // タイトルバーのフォントサイズを変更
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.systemFont(ofSize: 16)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)]
        
        // タイトルバーの背景色を変更
        UINavigationBar.appearance().barTintColor = UIColor(red: 238 / 255, green: 143 / 255, blue: 143 / 255, alpha: 0)
        // タイトルバーの裏の背景色を変更
        UINavigationBar.appearance().backgroundColor = UIColor(red: 238 / 255, green: 143 / 255, blue: 143 / 255, alpha: 0)
        // タブバーの背景色を変更
        UITabBar.appearance().barTintColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 0)
        // タブバーの裏の背景色を変更
        UITabBar.appearance().backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 0)
    }
    
    @EnvironmentObject var shareData: ShareData
    
    let messages = ["このアプリでは、\n「日中」に「カフェ」で\n「一緒に勉強する」\nという最初のデートを推奨しています。", "時間のかかるやり取りはなるべく短くし、会って、相手の空気感を感じてみてください。" , "お互いに勉強していれば会話が苦手でも大丈夫。「勉強」ですべての出会いが有意義なものになる。", "そんな真面目で安心な出会いを応援します。"]
    @State var index = 0
    
//    @State var x: CGFloat = 0
//    @State var count: CGFloat = 0
//    @State var screen = UIScreen.main.bounds.width
    
    @State var isModal = false
    
//    func getMid()->Int{
//        return self.shareData.pictures.count/2 //写真配列の中間地点を取得
//    }
    
    
    var body: some View {
        
        NavigationView {
            GeometryReader{ geometry in
                ZStack{
                    Color.gray.edgesIgnoringSafeArea(.all)
                    
//                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack(spacing: 0) {
//                            ForEach(0 ..< self.shareData.pictures.count) { index in
                        cardView(img: self.shareData.pictures[self.index], msg: self.messages[self.index], width: geometry.size.width, height: geometry.size.height).environmentObject(self.shareData)
                                                                    //
//                            }
//                        }
//                    }
                    
                    
                    //
                    VStack{
                        Spacer()
                        
                        NavigationLink(destination: LoginView().environmentObject(self.shareData)) {
                            Text("ログイン")
                                .foregroundColor(self.shareData.white)
                                .padding()
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05)
                                .background(self.shareData.pink).cornerRadius(10)
                                .shadow(radius: 2, y:2)
                        }
                        .padding(.vertical)
                        
                        
                        //                    NavigationLink(destination: RegisterView().environmentObject(self.shareData)) {
                        Button("新規登録"){
                            self.isModal = true
                        }
                        .foregroundColor(self.shareData.pink)
                        .padding()
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05)
                        .background(self.shareData.white)
                        .cornerRadius(10)
                        .shadow(radius: 2, y:2)
                        .padding(.bottom, 140)
                        
                        HStack(spacing: 50){
                            Button(action: {
                                if self.index == 0 {
                                    self.index = 3
                                } else {
                                    self.index -= 1
                                }
                                
                            }) {
                                Text("前へ").foregroundColor(self.shareData.white)
                            }
                            
                            
                            Button(action: {
                                if self.index == 3 {
                                    self.index = 0
                                } else {
                                    self.index += 1
                                }
                                
                            }) {
                                Text("次へ").foregroundColor(self.shareData.white)
                            }
                        }.padding(.bottom)
                    }
                    
                } //zstack
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
//                    .animation(.linear)
                
            }
            .sheet(isPresented: $isModal) {
                RegisterView().environmentObject(self.shareData)
            }
        } //navigationview
        
        
    }//body
}//struct

struct TopPageView_Previews: PreviewProvider {
    static var previews: some View {
        TopPageView()
    }
}

struct cardView: View{
    @EnvironmentObject var shareData: ShareData
    var img = ""
    var msg = ""
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    var body: some View{
        
        ZStack{
            
            Image(img)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: width, height: height).aspectRatio(contentMode: .fit)
            
            
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            
            Text(msg)
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.leading)
                .foregroundColor(self.shareData.white)
                .frame(width: width * 0.7)
                .offset(y: -40)
        }
        
        
    }
}
