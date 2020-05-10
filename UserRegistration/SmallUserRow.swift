//
//  SmallUserRow.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/04.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.


import SwiftUI

struct SmallUserRow: View {
    @EnvironmentObject var shareData: ShareData
    let user : User
    let geometry : GeometryProxy

    var body: some View {
      VStack{
          HStack{
              FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2)
                  .clipShape(Circle()).shadow(radius: 2, x:2, y:5)
                  .padding(.top, 8).padding(.leading)
              VStack(alignment: .leading,spacing: 5){
                  
                  
                   Text(user.name)
                   Text(user.age)
                  
              }.foregroundColor(self.shareData.black).frame(width: geometry.size.width * 0.5, alignment: .leading)
          } //hs
          if user.id == "" {
              Divider().hidden()
          } else {
              Divider()
          }
      }
}
}
//struct SmallUserRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SmallUserRow()
//    }
//}
