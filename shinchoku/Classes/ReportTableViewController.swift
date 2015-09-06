//
//  ReportTableViewController.swift
//  shinchoku
//
//  Created by 片岡崇史 on 2015/08/31.
//  Copyright © 2015年 kataoka. All rights reserved.
//

import UIKit
import MessageUI

class ReportTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, ItemTableDelegate {
    
    /** メールフォーマット サンプル
    =====
    [研究活動]
    * なし
    [講義関連]
    * 情報学群実験第4Cのレポートの作成を行った。
    [就職活動]
    * インターンシップ
    [研究室活動]
    * なし
    [その他]
    * swift railsの勉強
    =====
    */

    var reportItem: [String] = []
    var items: [[String]] = []
    var enableNum: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        setReportItem()
    }
    
    private func setReportItem() {
        reportItem.append("研究活動")
        items.append([])
        reportItem.append("講義関連")
        items.append([])
        reportItem.append("就職活動")
        items.append([])
        reportItem.append("研究室活動")
        items.append([])
        reportItem.append("その他")
        items.append([])
    }

    override func viewDidAppear(animated: Bool) {
        if (self.tableView.indexPathForSelectedRow != nil) {
            self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow!, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReportTableViewCell", forIndexPath: indexPath) as! ReportTableViewCell

        // Configure the cell...
        cell.labelTitle.text = self.reportItem[indexPath.row]

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toItemTableView",sender: indexPath.row)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier != "toItemTableView" {
            return
        }
        let viewController: ItemTableViewController = segue.destinationViewController as! ItemTableViewController
        viewController.delegate = self
        viewController.text = self.reportItem[sender as! Int]
        viewController.items = self.items[sender as! Int]
        enableNum = sender as! Int
    }

    
    func setTaskItems(items: [String]) {
        self.items[enableNum] = items
    }
    
    // 以下メール関係
    @IBAction func onButtonSendTouched(sender: AnyObject) {
        
        if MFMailComposeViewController.canSendMail() == false {
            print("MFMailCompose can not send mail")
            return
        }
        
        let mailViewController = MFMailComposeViewController()
        
        mailViewController.mailComposeDelegate = self
        
        mailViewController.setSubject("mm月dd日(w)〜mm月dd日(w)")
        
        let toRecipients = ["wrep@pl.info.kochi-tech.ac.jp"]
        mailViewController.setToRecipients(toRecipients)
        
        mailViewController.setMessageBody(createMailBody(), isHTML: false)
        
        self.presentViewController(mailViewController, animated: true, completion: nil)
        
    }
    
    private func createMailBody() -> String {
        var body: String = ""
        body += "=====\n"
        for (var i = 0; i < reportItem.count; i++) {
            body += "[" + reportItem[i] + "]\n"
            if items[i].count == 0 {
                body += "* なし\n"
            } else {
                for j in items[i] {
                    body += "* " + j + "\n"
                }
            }
        }
        body += "====="
        return body
    }

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Email Send Cancelled")
            break
        case MFMailComposeResultSaved.rawValue:
            print("Email Saved as a Draft")
            break
        case MFMailComposeResultSent.rawValue:
            print("Email Sent Successfully")
            break
        case MFMailComposeResultFailed.rawValue:
            print("Email Send Failed")
            break
        default:
            break
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
