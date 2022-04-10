//
//  ViewController.swift
//  MC1-Group12
//
//  Created by Karen Natalia on 07/04/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        askPermissionNotifications()
    }

    func askPermissionNotifications() {
        let notifCenter = UNUserNotificationCenter.current()
        
        notifCenter.requestAuthorization(options: [.alert]) { granted, error in
            if granted == true {
                print("Permission Granted")
            }
            else {
                print("Permission Not Granted")
            }
        }
    }
    
}

