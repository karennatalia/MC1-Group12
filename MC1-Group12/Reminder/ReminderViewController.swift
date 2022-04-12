//
//  ReminderViewController.swift
//  MC1-Group12
//
//  Created by Mohammad Alfarisi on 11/04/22.
//

import UIKit

class ReminderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toAddReminder(_ sender: Any) {
        guard let addReminderStoryboard = storyboard?.instantiateViewController(withIdentifier: "AddReminderStoryboard") as?
                AddReminderViewController else {
            return
        }
        
        addReminderStoryboard.snapshot = self.navigationController?.view.asImage()
        addReminderStoryboard.modalPresentationStyle = .fullScreen
        self.present(addReminderStoryboard, animated: false, completion: nil)
    }
}
