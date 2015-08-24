//
//  ViewController.swift
//  shinchoku
//
//  Created by 片岡崇史 on 2015/08/24.
//  Copyright (c) 2015年 kataoka. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
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
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func createMailBody() -> String {
        var body: String = ""
        body += "====="
        body += "\n[研究活動]\n* "
        if textField1.text.isEmpty {
            body += "なし"
        } else {
            body += textField1.text
        }
        body += "\n[講義関連]\n* "
        if textField2.text.isEmpty {
            body += "なし"
        } else {
            body += textField2.text
        }
        body += "\n[就職活動]\n* "
        if textField3.text.isEmpty {
            body += "なし"
        } else {
            body += textField3.text
        }
        body += "\n[研究室活動]\n* "
        if textField4.text.isEmpty {
            body += "なし"
        } else {
            body += textField4.text
        }
        body += "\n[その他]\n* "
        if textField5.text.isEmpty {
            body += "なし"
        } else {
            body += textField5.text
        }
        body += "\n=====\n"

        println(body)
        return body
    }

    @IBAction func onBtnSendTouched(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() == false {
            println("MFMailCompose can not send mail")
            return
        }
        
        println("ok!")
        createMailBody()
        
        var mailViewController = MFMailComposeViewController()
        
        mailViewController.mailComposeDelegate = self
        
        mailViewController.setSubject("MessageUI test")
        
        var toRecipients = ["gyanexus7@gmail.com"]
        mailViewController.setToRecipients(toRecipients)
        
        mailViewController.setMessageBody(createMailBody(), isHTML: false)
        
        self.presentViewController(mailViewController, animated: true, completion: nil)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        switch result.value {
        case MFMailComposeResultCancelled.value:
            println("Email Send Cancelled")
            break
        case MFMailComposeResultSaved.value:
            println("Email Saved as a Draft")
            break
        case MFMailComposeResultSent.value:
            println("Email Sent Successfully")
            break
        case MFMailComposeResultFailed.value:
            println("Email Send Failed")
            break
        default:
            break
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

