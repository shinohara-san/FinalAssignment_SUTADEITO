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
    //    @Binding var hometown: String
    //    @Binding var purpose: String
    //    @Binding var subject: String
    
    @State var selectedHometown = 20
    @State var selectedStudystyle = 1
    @State var selectedPurpose = 1
    
    var body: some View {
        GeometryReader{ geo in
            //            ZStack{
            //                Color.black.edgesIgnoringSafeArea(.all).opacity(0.3)
            ScrollView(showsIndicators: false){
                VStack(alignment: .center){
                    HStack(alignment: .firstTextBaseline){
                        Text("条件をひとつ選んでください")
                        .foregroundColor(Color(red: 42/255, green: 34/255, blue: 56/255))
                        .padding(.top)
                        
                        Button(action: {
                            self.shareData.searchBoxOn = false
                        }) {
                            Image(systemName: "multiply").foregroundColor(Color.myPink)
                        }
                    }
                    
                    Section{
                        
                        
                        Picker(selection: self.$selectedHometown, label: Text("")) {
                            ForEach(0..<self.shareData.hometowns.count){ index in
                                Text(self.shareData.hometowns[index]).tag(index)
                            }
                        }.labelsHidden()
                        
                        
                        Button(action: {
                            self.shareData.searchUser(key: "hometown", value: self.shareData.hometowns[self.selectedHometown])
                            self.shareData.searchBoxOn = false
                        }) {
                            Text("現住所で検索").padding().foregroundColor(Color.myWhite).background(Color.myPink).shadow(radius: 2, x:2, y:2).cornerRadius(10)
                        }
                    }
                    Section{
                        
                        Picker(selection: self.$selectedStudystyle, label: Text("")) {
                            ForEach(0..<self.shareData.studystyles.count){ index in
                                Text(self.shareData.studystyles[index]).tag(index).font(.subheadline)
                            }
                        }.labelsHidden()
                        
                        
                        Button(action: {
                            self.shareData.searchUser(key: "studystyle", value: self.shareData.studystyles[self.selectedStudystyle])
                            self.shareData.searchBoxOn = false
                        }) {
                            Text("すたでいとで検索").padding().foregroundColor(Color.myWhite).background(Color.myPink).shadow(radius: 2, x:2, y:2).cornerRadius(10)
                           
                        }
                    }
                    
                    Section{
                        //
                        Picker(selection: self.$selectedPurpose, label: Text("")) {
                            ForEach(0..<self.shareData.purposes.count){ index in
                                Text(self.shareData.purposes[index]).tag(index)
                            }
                        }
                        .labelsHidden()
                        
                        Button(action: {
                            self.shareData.searchUser(key: "purpose", value: self.shareData.purposes[self.selectedPurpose])
                            self.shareData.searchBoxOn = false
                        }) {
                            Text("目的で検索").padding().foregroundColor(Color.myWhite).background(Color.myPink).shadow(radius: 2, x:2, y:2).cornerRadius(10)
                            //                                .frame(width: geo.size.width * 1, height: geo.size.height * 0.2)
                        }
                    }.padding(.bottom)
                    //                    }
                    
                }//vstack
                
            } //sc
        } //ge
    }//bod
}//view

//struct SearchBoxView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBoxView()
//    }
//}

struct SearchBoxView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
