//
//  ReminderViewController.swift
//  MC1-Group12
//
//  Created by Mohammad Alfarisi on 11/04/22.
//

import UIKit

class ReminderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var reminders = [Reminder]()
    
    @IBOutlet weak var remindersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remindersTableView.delegate = self
        remindersTableView.dataSource = self
        remindersTableView.register(ReminderHeaderViewController.self,
            forHeaderFooterViewReuseIdentifier: "reminderHeader")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return reminders.count
        
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath)
        
        if let reminderCell = cell as? ReminderCellViewController {
            reminderCell.reminderTimeLabel.text = "15.00"

            return reminderCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                    "reminderHeader") as! ReminderHeaderViewController
        
        view.dayLabel = UILabel()
        view.dayLabel.text = "Monday"
        view.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        view.dayLabel.font = UIFont.systemFont(ofSize: CGFloat(18), weight: .heavy)
         
        view.contentView.addSubview(view.dayLabel)
        
        return view
    }
}
