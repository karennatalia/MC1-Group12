//
//  ReminderViewController.swift
//  MC1-Group12
//
//  Created by Mohammad Alfarisi on 11/04/22.
//

import UIKit
import UserNotifications

protocol ReminderViewControllerDelegate {
    func addNewReminder(day: DayOfWeek, time: Date) -> UUID
    func updateReminder(targetId: UUID, day: DayOfWeek, time: Date)
}

class ReminderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ReminderViewControllerDelegate {
    
    @IBOutlet weak var remindersTableView: UITableView!
    
    @IBOutlet weak var vwContainer3: UIView!
    
    let tableHeaderHeight = CGFloat(30)
    
    let reminderModel = ReminderModel.instance
    
    let notifCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderModel.getReminders()
        
        vwContainer3.layer.shadowColor = UIColor.black.cgColor
        vwContainer3.layer.shadowOffset = .zero
        vwContainer3.layer.shadowOpacity = 0.5
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
        addReminderStoryboard.isEditWeekday = -1
        
        self.present(addReminderStoryboard, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return reminderModel.reminderDays.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let addReminderStoryboard = storyboard?.instantiateViewController(withIdentifier: "AddReminderStoryboard") as? AddReminderViewController else {
            return
        }
        
        let day = reminderModel.reminderDays[indexPath.section]
        
        if let weekday = DayOfWeek.allCases.firstIndex(of: day) {
            addReminderStoryboard.isEditWeekday = weekday
        }
        
        addReminderStoryboard.reminderDelegate = self
        addReminderStoryboard.isEditSection = indexPath.section
        addReminderStoryboard.isEditRow = indexPath.row
        
        self.present(addReminderStoryboard, animated: true, completion: nil)
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
            
            cell.reminderSwitch.isOn = reminder.isEnabled
            
            cell.onSwitched = { [weak self]
                isOn in
                
                self?.reminderModel.toggleReminder(targetId: reminder.id, day: day)
                
                // Start notif
                if (isOn) {
                    guard let weekday = DayOfWeek.allCases.firstIndex(of: day) else { return }
                    
                    self?.scheduleNotif(id: reminder.id, time: reminder.time, weekday: weekday + 1)
                    
                    return
                }
                
                // Delete notif
                self?.notifCenter.removePendingNotificationRequests(withIdentifiers: ["\(reminder.id)"])
            }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            let day = reminderModel.reminderDays[indexPath.section]
            
            if let reminder = reminderModel.reminders[day]?[indexPath.row] {
                
                reminderModel.removeReminder(targetId: reminder.id, day: day)
                
                notifCenter.removePendingNotificationRequests(withIdentifiers: ["\(reminder.id)"])
            }
            
            tableView.reloadData()
        }
    }
    
    func addNewReminder(day: DayOfWeek, time: Date) -> UUID {
        let id = reminderModel.addReminder(day: day, time: time)
        
        remindersTableView.reloadData()
        
        return id
    }
    
    func updateReminder(targetId: UUID, day: DayOfWeek, time: Date) {
        reminderModel.updateReminder(targetId: targetId, day: day, time: time)
            
        remindersTableView.reloadData()
    }
    
    func scheduleNotif(id: UUID, time: Date, weekday: Int) {
        /// Set the content of notifications
        let reminderContent = UNMutableNotificationContent()
        reminderContent.title = "Have you interacted with your child today? "
        reminderContent.body = "Let’s find an activity for you! Don't forget to interact with your child and communicate with them every day!"
        reminderContent.sound = .default
        
        /// Set trigger "WHEN" to send the notifications
        var reminderTime = Calendar.current.dateComponents([.hour, .minute], from: time)
        reminderTime.weekday = weekday
        let timeTrigger = UNCalendarNotificationTrigger(dateMatching: reminderTime, repeats: true)
        
        /// Send notifications request ke Notification Center
        let request = UNNotificationRequest(identifier: id.uuidString, content: reminderContent, trigger: timeTrigger)
        self.notifCenter.add(request, withCompletionHandler: nil)
    }
    
}
