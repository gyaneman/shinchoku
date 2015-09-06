//
//  ItemCreationViewController.swift
//  shinchoku
//
//  Created by 片岡崇史 on 2015/08/31.
//  Copyright © 2015年 kataoka. All rights reserved.
//

import UIKit

protocol ItemCreationDelegate {
    func appendItem(item: String)
}

class ItemCreationViewController: UIViewController , UITextFieldDelegate {
    var delegate: ItemCreationDelegate?
    
    @IBOutlet weak var textFieldItem: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldItem.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButtonTouched(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onAddingButtonTouched(sender: AnyObject) {
        self.delegate!.appendItem(self.textFieldItem.text!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
