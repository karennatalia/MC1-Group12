//
//  ReminderViewController.swift
//  MC1-Group12
//
//  Created by Mohammad Alfarisi on 11/04/22.
//

import UIKit

protocol ReminderViewControllerDelegate {
    func addNewReminder(day: DayOfWeek, time: Date)
}

class ReminderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ReminderViewControllerDelegate {
    
    @IBOutlet weak var remindersTableView: UITableView!
    
    @IBOutlet weak var vwContainer3:UIView!
    
    let tableHeaderHeight = CGFloat(36)
    
    let reminderModel = ReminderModel.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        vwContainer3.layer.shadowColor = UIColor.black.cgColor
        vwContainer3.layer.shadowOffset = .zero
        vwContainer3.layer.shadowOpacity = 1
        vwContainer3.layer.shadowRadius = 15
        vwContainer3.layer.shadowPath = UIBezierPath(rect: vwContainer3.bounds).cgPath
        vwContainer3.layer.shouldRasterize = true
        
        remindersTableView.delegate = self
        remindersTableView.dataSource = self
    }
    
    @IBAction func toAddReminder(_ sender: Any) {
        guard let addReminderStoryboard = storyboard?.instantiateViewController(withIdentifier: "AddReminderStoryboard") as? AddReminderViewController else {
            return
        }
        
        addReminderStoryboard.reminderDelegate = self
        
        self.present(addReminderStoryboard, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return reminderModel.reminderDays.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get day of week
        let day = reminderModel.reminderDays[section]
        
        // Return how many reminders are saved for the day
        let count = reminderModel.reminders[day]?.count ?? 0
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as! ReminderCellViewController
        
        let day = reminderModel.reminderDays[indexPath.section]
        
        if let reminder = reminderModel.reminders[day]?[indexPath.row] {
            cell.reminderTimeLabel.text = reminder.formattedTime
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return tableHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let day = reminderModel.reminderDays[section]
        
        // Code below builds a header
        let headerView = UIView.init(frame:
                CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: tableHeaderHeight))
        
        let label = UILabel()
        
        label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        
        label.text = day.rawValue
        
        label.font = .systemFont(ofSize: CGFloat(18), weight: .heavy)
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func addNewReminder(day: DayOfWeek, time: Date) {
        reminderModel.addReminder(day: day, time: time)
        
        remindersTableView.reloadData()
    }
}
