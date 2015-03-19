//
//  AI_gcd.swift
//  OCR
//
//  Created by Alexander Ignition on 19.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

import Foundation

struct ai_queue {
    static let main = dispatch_get_main_queue()
    static let user_interactive = dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.value), 0)
    static let user_initiated = dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)
    static let default_q = dispatch_get_global_queue(Int(QOS_CLASS_DEFAULT.value), 0)
    static let utility = dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.value), 0)
    static let background = dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.value), 0)
}