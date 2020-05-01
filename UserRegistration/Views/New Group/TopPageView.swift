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
        // タイトルバーの背景色を変更
        UINavigationBar.appearance().barTintColor = UIColor(red: 238 / 255, green: 143 / 255, blue: 143 / 255, alpha: 0.9)
        // タイトルバーの裏の背景色を変更
        UINavigationBar.appearance().backgroundColor = UIColor(red: 238 / 255, green: 143 / 255, blue: 143 / 255, alpha: 1)
        // タブバーの背景色を変更
        UITabBar.appearance().barTintColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
        // タブバーの裏の背景色を変更
        UITabBar.appearance().backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
    }
    
    @EnvironmentObject var shareData: ShareData
    
    let pictures = ["tables" ,"people" ,"coffee" ,"couple"]
    let messages = ["このアプリでは、\n「日中」に「カフェ」で\n「一緒に勉強する」\nという最初のデートを推奨しています。", "時間のかかるやり取りはなるべく短くし、会って、相手の空気感を感じてみてください。" , "お互いに勉強していれば会話が苦手でも大丈夫。「勉強」ですべての出会いが有意義なものになる。", "そんな真面目で安心な出会いを応援します。"]
    @State var index = 0
    
    @State var x: CGFloat = 0
    @State var count: CGFloat = 0
    @State var screen = UIScreen.main.bounds.width
    
    func getMid()->Int{
        return pictures.count/2
    }
    
    
    var body: some View {
        
        NavigationView {
            GeometryReader{ geometry in
            ZStack{
                
                    ScrollView(.horizontal, showsIndicators: true){
                        HStack(spacing: 0) {
                            ForEach(0 ..< self.pictures.count) { index in
                                cardView(img: self.pictures[index], msg: self.messages[index], width: geometry.size.width, height: geometry.size.height).environmentObject(self.shareData)
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
                
                
                //
                VStack{
                    Spacer()
                    
                    NavigationLink(destination: LoginView().environmentObject(self.shareData)) {
                        Text("ログイン")
                            .foregroundColor(self.shareData.white)
                            .padding()
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.05)
                            .background(self.shareData.pink).cornerRadius(10)
                    }
                    .padding(.bottom)
                    
                    NavigationLink(destination: RegisterView().environmentObject(self.shareData)) {
                        Text("新規登録")
                            .foregroundColor(self.shareData.pink)
                            .padding()
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.05)
                            .background(self.shareData.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 200)
                }
                
            } //zstack
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .animation(.spring())
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
                .offset(y: -30)
        }
        
        
    }
}
