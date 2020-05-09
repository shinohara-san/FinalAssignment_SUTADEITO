//
//  User.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/15.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation

struct User: Identifiable, Equatable, Hashable{
    let id: String
    let email: String
//    var password: String
    let name: String
    let gender: String
    let age: String
    let hometown: String
    let subject: String
    let introduction: String
    let studystyle: String
    let hobby: String
    let personality: String
    let work: String
    let purpose: String
    let photoURL: String
    let matchRoomId: String
    let fee: String
    let schedule: String
    let place: String
//    var uid: String
}


//subjectとpurposeをさらに配列にして第１第２と順序づけしたい
