//
//  SearchBoxView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/06.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct SearchBoxView: View {
    @EnvironmentObject var shareData:ShareData
    @Binding var hometown: String
    @Binding var purpose: String
    @Binding var subject: String
    
    var body: some View {
        GeometryReader{ geo in
//            ZStack{
//                Color.black.edgesIgnoringSafeArea(.all).opacity(0.3)
        VStack{
            
                Text("条件をひとつ入れてください")
                    .foregroundColor(Color(red: 42/255, green: 34/255, blue: 56/255))
                    .padding(.top)
                
                HStack{
                    TextField("current city", text: self.$hometown).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    
                    Button(action: {
                        self.shareData.searchUser(key: "hometown", value: self.hometown)
                        self.purpose = ""
                        self.subject = ""
                        self.shareData.searchBoxOn = false
                    }) {
                        Image(systemName: "magnifyingglass.circle.fill").resizable().frame(width: geo.size.width * 0.1, height: geo.size.height * 0.08).accentColor(.yellow)
                    }
                    .padding(.trailing)
                }
                
                HStack{
                    TextField("purpose", text: self.$purpose).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    
                    Button(action: {
                        self.shareData.searchUser(key: "purpose", value: self.purpose)
                        self.hometown = ""
                        self.subject = ""
                        self.shareData.searchBoxOn = false
                    }) {
                        Image(systemName: "magnifyingglass.circle.fill").resizable().frame(width: geo.size.width * 0.1, height: geo.size.height * 0.08).accentColor(.green)
                    }
                    .padding(.trailing)
                }
                HStack{
                    TextField("subject", text: self.$subject).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    
                    Button(action: {
                        self.shareData.searchUser(key: "subject", value: self.subject)
                        self.hometown = ""
                        self.purpose = ""
                        self.shareData.searchBoxOn = false
                    }) {
                        Image(systemName: "magnifyingglass.circle.fill").resizable().frame(width: geo.size.width * 0.1, height: geo.size.height * 0.08).accentColor(.purple)
                    }
                    .padding(.trailing)
                }
    
        }//vstack
            
//        }
        }
    }
}

//struct SearchBoxView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBoxView()
//    }
//}
