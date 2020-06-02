//
//  Extension.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/19.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    public static let myPink: Color = Color(red: 250 / 255, green: 138 / 255, blue: 148 / 255)
    public static let myWhite: Color = Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255)
    public static let myWhite2: Color = Color(red: 248/255, green: 248/255, blue: 248/255)
    public static let myYellow: Color = Color(red: 255/255, green: 244/255, blue: 148/255)
    public static let myGreen: Color = Color(red: 144/255, green: 238/255, blue: 144/255)
    public static let myBlack: Color = Color(red: 51/255, green: 51/255, blue: 51/255)
    public static let myBrown: Color = Color(red: 205/255, green: 181/255, blue: 166/255)
}

extension Text {
    func textStyle(fcolor: Color, bgcolor: Color, geometry: GeometryProxy) -> some View {
        self
            .foregroundColor(fcolor)
            .padding()
            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05)
            .background(bgcolor).cornerRadius(10)
            .shadow(radius: 2, y:2)
            
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
