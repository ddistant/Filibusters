//
//  FBConversation.swift
//  Filibuster
//
//  Created by Daniel Distant on 1/17/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

import UIKit

class FBConversation: NSObject {
    
    let recipient : String
    let timer : NSTimer
    
    var messages : [String] = [String]()
    
    var isNotifiying : Bool = true
    
    enum tone: Int {
        case nice = 0
        case neutral = 1
        case mean = 2
    }
    
    init(recipient: String, timer: NSTimer, var tone: Int) {
        self.recipient = recipient
        self.timer = timer
        tone = 1
    }
    
    

}
