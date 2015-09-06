//
//  ItemTableViewController.swift
//  shinchoku
//
//  Created by 片岡崇史 on 2015/08/31.
//  Copyright © 2015年 kataoka. All rights reserved.
//

import UIKit

protocol ItemTableDelegate {
    func setTaskItems(items: [String])
}

class ItemTableViewController: UITableViewController, UITextFieldDelegate, ItemCreationDelegate {
    var delegate: ItemTableDelegate?
    
    var text: String?
    var items: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.title = text
    }
    
    override func viewDidAppear(animated: Bool) {
        
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
        return items!.count + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if indexPath.row != items!.count {
            cell = tableView.dequeueReusableCellWithIdentifier("ItemTableViewCell", forIndexPath: indexPath)
            (cell as! ItemTableViewCell).labelNumber.text = indexPath.row.description
            (cell as! ItemTableViewCell).labelText.text = self.items![indexPath.row]
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("ItemAddTableViewCell", forIndexPath: indexPath)
        }
        //let cell = tableView.dequeueReusableCellWithIdentifier("ItemTableViewCell", forIndexPath: indexPath) as! ItemTableViewCell

        return cell!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*if indexPath.row == items!.count {
            performSegueWithIdentifier("toItemCreationView",sender: indexPath.row)
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }*/
        performSegueWithIdentifier("toItemCreation", sender: indexPath)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.row >= self.items!.count {
            return false
        }
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.items?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        if indexPath.row >= self.items!.count {
            return false
        }
        return true
    }
    

    
    // MARK: - Navigation

    func appendItem(item: String) {
        self.items!.append(item)
        self.tableView.reloadData()
        self.delegate!.setTaskItems(items!)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toItemCreation" {
            let viewController = segue.destinationViewController as! ItemCreationViewController
            viewController.delegate = self
            if sender!.row != self.items!.count {
                viewController.textFieldItem.text = items![(sender as! NSIndexPath).row]
            } else {
                
            }
        }
    }


}
