//
//  ViewController.swift
//  MC1-Group12
//
//  Created by Karen Natalia on 07/04/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    func getWelcomeTime() {
        let hour = Calendar.current.component(.hour, from: Date())
       
        switch hour {
            case 6..<12 :
            welcomeLabel.text = "Good " +  NSLocalizedString("Morning", comment: "Morning")
            case 12..<15 :
            welcomeLabel.text = "Good " +  NSLocalizedString("Afternoon", comment: "Afternoon")
            case 15..<18 :
            welcomeLabel.text = "Good " +  NSLocalizedString("Evening", comment: "Evening")
            default:
            welcomeLabel.text = "Good " +  NSLocalizedString("Night", comment: "Night")
        }
    }

    let notifCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        getWelcomeTime()
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
    
}

