//
//  Message.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/23.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation
import Firebase

struct Message: Identifiable {
    var id: String
    var msg: String
    var fromUser: String
    var toUser: String
    var date: Timestamp
}
