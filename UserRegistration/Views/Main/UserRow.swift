//
//  UserRow.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/04.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct UserRow: View{
       @EnvironmentObject var shareData: ShareData
       let user : User
       let geometry : GeometryProxy
       
       var body: some View{
        VStack{
           HStack(spacing: 0){
               //                                        Spacer()
               VStack{
                   FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2, alignment: .leading)
                       .clipShape(Circle()).shadow(radius: 2, x:2, y:2)
                       .padding(.top, 8)
                   HStack(spacing: 5){
                       Spacer()
                       Text(user.age).frame(width: geometry.size.width * 0.2, alignment: .trailing)
                       Text(user.hometown).frame(width: geometry.size.width * 0.3, alignment: .leading)
                   }.frame(width: geometry.size.width * 0.5)
                
               }
            
               HStack(spacing: 0){
                   chatBubbleTriange(width: geometry.size.width * 0.08, height: geometry.size.height * 0.05, isIncoming: true)
                   Text(user.subject).padding(7).frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.2, alignment: .leading).background(self.shareData.brown).foregroundColor(self.shareData.white).cornerRadius(10).shadow(radius: 2, x: 2, y: 2)
            }
               
           }
            Divider()
        }
       }
    
    private func chatBubbleTriange(
        width: CGFloat,
        height: CGFloat,
        isIncoming: Bool) -> some View {
        
        Path { path in
            path.move(to: CGPoint(x: 0, y: height * 0.5))
            path.addLine(to: CGPoint(x: width, y: height * 0.7))
            path.addLine(to: CGPoint(x: width, y: 0))
            path.closeSubpath()
        }
        .fill(shareData.brown)
        .frame(width: width, height: height)
        .shadow(radius: 2, x: 2, y: 2)
        .zIndex(10)
        .clipped()
        .padding(.trailing, -1)
        .padding(.leading, 10)
        .padding(.bottom, 12)
    }
    
   }

//struct UserRow_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRow()
//    }
//}
