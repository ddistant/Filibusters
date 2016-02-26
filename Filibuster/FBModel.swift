//
//  FBModel.swift
//  Filibuster
//
//  Created by Daniel Distant on 1/17/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

import GameKit
import UIKit

class FBModel: NSObject {
    
    let prefixes = ["hmmm.. ", "umm ... ", "uhh ", "really? ", "lol "]
    
    let niceResponses = ["let me think about it", "i'll get back to you on that", "i'll let you know", "you're crazy lol", "well you'll find out, won't you?"]
    
    let neutralResponses = ["idk", "what do you mean?", "now I'm confused", "maybe", "i'll see", "???", "i'm not sure yet", "oook"]
    
    let meanResponses = ["OMG you are so annoying", "could you leave me alone", "didn't we discuss this already?", "you're getting on my nerves", "are you seriously still texting me?", "smh", "*annoyed emoji*", "*mad emoji*"]
    
    //for user-created auto-responses
    
    var userResponses : [String] = [String]()
    
    //this method won't stay here
    
    func respond() -> String {
        
        let arr1 = niceResponses
        let arr2 = neutralResponses
        let arr3 = meanResponses
        let arr4 = prefixes
        
        let num = GKRandomSource.sharedRandom().nextIntWithUpperBound(99)
        
        if num < 33 {
            var arrCopy = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(arr1)
            
            if num % 6 == 0 {
                var preCopy = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(arr4)
                return String(preCopy[0]) + String(arrCopy[0])
            }
            return arrCopy[0] as! String
        } else if num > 33 && num < 66 {
            var arrCopy = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(arr2)
            if num % 6 == 0 {
                var preCopy = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(arr4)
                return String(preCopy[0]) + String(arrCopy[0])
            }
            return arrCopy[0] as! String
        } else {
            var arrCopy = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(arr3)
            if num % 6 == 0 {
                var preCopy = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(arr4)
                return String(preCopy[0]) + String(arrCopy[0])
            }
            return arrCopy[0] as! String
        }
    }

}
