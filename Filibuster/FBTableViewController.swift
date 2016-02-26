//
//  FBTableViewController.swift
//  Filibuster
//
//  Created by Daniel Distant on 1/17/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
import MessageUI

typealias KVOContext = Int
var observationContext = KVOContext()

class FBTableViewController: UITableViewController, CNContactPickerDelegate, UIPickerViewDelegate {
    
    var conversations : [FBConversation] = [FBConversation]()
    var fetchedContact : CNContact = CNContact()
    let messageComposer = FBMessageComposer()
    let messageViewController = FBMessageComposeViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.title = "Filibuster!"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        
        if CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts) == CNAuthorizationStatus.NotDetermined {
            getUserPermissions()
        } else if CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts) == CNAuthorizationStatus.Denied || CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts) == CNAuthorizationStatus.Restricted {
            permissionsNecessary()
        } else {
           presentContactPicker()
        }
        
    }
    
    /*
    
    // MARK: - KVO
    
    func startObserving(messageViewController : FBMessageComposeViewController) {
        
        let options = NSKeyValueObservingOptions([.New, .Old])
        messageViewController.addObserver(self, forKeyPath: "contact", options: options, context: &observationContext)
    }
    
    func stopObserving() {
        
        messageViewController.removeObserver(self, forKeyPath: "contact", context: &observationContext)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        guard keyPath != nil else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            return
        }
        
        switch(keyPath, context) {
        case("contact"?, &observationContext):
            
            print("")
            
        case(_, &observationContext):
            assert(false, "unknown key path")
            
        default:
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            
        }
    }

*/
    
    //MARK: - Helper methods
    
    func showMessageViewController() {
        presentViewController(messageViewController, animated: true, completion: nil)
        
//        completion(self.self.messageViewController) completion : FBMessageComposeViewController -> Void
    }
    
    func topMostViewController() -> UIViewController {
        
        var topViewController : UIViewController = (UIApplication.sharedApplication().keyWindow?.rootViewController)!
        
        while (topViewController.presentedViewController != nil) {
            topViewController = topViewController.presentedViewController!
        }
        
        return topViewController
    }
    
    // MARK: - user permissions
    
    func getUserPermissions() {
        let alertController = UIAlertController(title: "Filibuster would like to access your contacts", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
           CNAuthorizationStatus.Authorized
            
            self.presentContactPicker()
        })
        
        let dismissAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action:UIAlertAction!) -> Void in
            CNAuthorizationStatus.Denied
            
            self.permissionsNecessary()
        }
        
        alertController.addAction(okAction)
        alertController.addAction(dismissAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func permissionsNecessary () {
        let alertController = UIAlertController(title: "Access denied", message: "To filibuster, please allow access to contacts in settings", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Contact picker functions
    
    func presentContactPicker() {
       let contactPickerViewController = FBContactPickerViewController()
        
        contactPickerViewController.delegate = self
        
        presentViewController(contactPickerViewController, animated: true, completion: nil)
        
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        
        navigationController?.popViewControllerAnimated(true)
        
        //contact doesn't work
        
//        fetchedContact = contact
        
        if messageComposer.canSendText(messageViewController) {
            
            let pn = String(fetchedContact.phoneNumbers.first?.value)
            
            messageViewController.recipients?.append(pn)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.showMessageViewController()
            })
            
        } else {
            
            let alertController = UIAlertController(title: "Access denied", message: "This device cannot use text messaging. Please check settings.", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            alertController.addAction(okAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // change to conversations.count

        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath)

        cell.textLabel?.text = "Filibuster!"
        cell.detailTextLabel?.text = "867-5309"

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
