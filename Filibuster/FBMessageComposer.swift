//
//  FBMessageComposer.swift
//  Filibuster
//
//  Created by Daniel Distant on 1/17/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

import Foundation
import MessageUI
import UIKit

class FBMessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    
//    let textMessageRecipient = ["1-914-907-2396"]
    
    var messageViewController = FBMessageComposeViewController?()
    
    func canSendText(messageViewController : FBMessageComposeViewController) -> Bool {
        
        if FBMessageComposeViewController.canSendText() {
            
            self.messageViewController = messageViewController
            
            self.messageViewController!.messageComposeDelegate = self
            
            return true
        }
        
        return false
    }
    
//    func configuredMessageComposeController() -> MFMessageComposeViewController {
//        let messageComposeVC = MFMessageComposeViewController()
//        messageComposeVC.messageComposeDelegate = self
//        messageComposeVC.recipients = textMessageRecipient
//        messageComposeVC.body = "This text is coming from filibuster!"
//        
//        return messageComposeVC
//    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        if (result == MessageComposeResultCancelled) || (result == MessageComposeResultFailed) {
           controller.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }

}
