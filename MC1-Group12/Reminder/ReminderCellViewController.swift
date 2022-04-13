//
//  ReminderCellViewController.swift
//  MC1-Group12
//
//  Created by Mohammad Alfarisi on 11/04/22.
//

import UIKit

class ReminderCellViewController: UITableViewCell {
    
    var onSwitched: ((Bool) -> Void)?
    
    @IBOutlet weak var reminderTimeLabel: UILabel!
    
    @IBOutlet weak var reminderSwitch: UISwitch!
    
    @IBAction func reminderSwitchAction(_ sender: UISwitch) {
        onSwitched?(sender.isOn)
    }
}
