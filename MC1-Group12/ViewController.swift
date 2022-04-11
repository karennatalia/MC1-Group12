//
//  ViewController.swift
//  MC1-Group12
//
//  Created by Karen Natalia on 07/04/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let notifCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        notifCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted == true {
                print("Permission Granted")
            }
            else {
                print("Permission Not Granted")
            }
        }
    }
    
    @IBAction func ToReminderTestPage(_ sender: Any) {
        performSegue(withIdentifier: "toReminderTestPage", sender: self)
    }
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func toActivityDetails(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "activitydetails") as! ActivityDetailsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

