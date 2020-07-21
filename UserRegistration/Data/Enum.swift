//
//  Enum.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/06/03.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation
import SwiftUI

enum SFSymbol{
    static let forList = Image(systemName: "book.fill")
    static let forSearch = Image(systemName: "magnifyingglass")
    static let forFaveriteLike = Image(systemName: "star.fill")
    static let forGivenLike = Image(systemName: "suit.heart")
    static let forMatch = Image(systemName: "suit.heart.fill")
    static let thumbsUp = Image(systemName: "hand.thumbsup.fill")
    static let home = Image(systemName: "house.fill")
    static let close = Image(systemName: "multiply")
}

enum EmptyUser{
    static let forLayout = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "", fee: "", schedule: "", place: "")
}

