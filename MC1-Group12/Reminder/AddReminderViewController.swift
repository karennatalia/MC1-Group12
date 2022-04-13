//
//  AddReminderViewController.swift
//  MC1-Group12
//
//  Created by Karen Natalia on 11/04/22.
//

import UIKit
import UserNotifications

class AddReminderViewController: UIViewController {
    
    var reminderDelegate : ReminderViewControllerDelegate?
    
    @IBOutlet weak var sundayBtnUI: UIButton!
    @IBOutlet weak var mondayBtnUI: UIButton!
    @IBOutlet weak var tuesdayBtnUI: UIButton!
    @IBOutlet weak var wednesdayBtnUI: UIButton!
    @IBOutlet weak var thursdayBtnUI: UIButton!
    @IBOutlet weak var fridayBtnUI: UIButton!
    @IBOutlet weak var saturdayBtnUI: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    let notifCenter = UNUserNotificationCenter.current()
    var selectedWeekday:[Int] = [0,0,0,0,0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium()
            ]
            presentationController.prefersGrabberVisible = true
        }
        
        sundayBtnUI.layer.cornerRadius = 5
        mondayBtnUI.layer.cornerRadius = 5
        tuesdayBtnUI.layer.cornerRadius = 5
        wednesdayBtnUI.layer.cornerRadius = 5
        thursdayBtnUI.layer.cornerRadius = 5
        fridayBtnUI.layer.cornerRadius = 5
        saturdayBtnUI.layer.cornerRadius = 5
        
    }
    
    @IBAction func SundayClicked(_ sender: UIButton) {
        if checkDay(weekday: 0) == 1 {
            sender.backgroundColor = UIColor.purple
            sender.tintColor = UIColor.white
        }
        else {
            sender.backgroundColor = UIColor.systemGray6
            sender.tintColor = UIColor.black
        }
    }
    @IBAction func MondayClicked(_ sender: UIButton) {
        if checkDay(weekday: 1) == 1 {
            sender.backgroundColor = UIColor.purple
            sender.tintColor = UIColor.white
        }
        else {
            sender.backgroundColor = UIColor.systemGray6
            sender.tintColor = UIColor.black
        }
    }
    @IBAction func TuesdayClicked(_ sender: UIButton) {
        if checkDay(weekday: 2) == 1 {
            sender.backgroundColor = UIColor.purple
            sender.tintColor = UIColor.white
        }
        else {
            sender.backgroundColor = UIColor.systemGray6
            sender.tintColor = UIColor.black
        }
    }
    @IBAction func WednesdayClicked(_ sender: UIButton) {
        if checkDay(weekday: 3) == 1 {
            sender.backgroundColor = UIColor.purple
            sender.tintColor = UIColor.white
        }
        else {
            sender.backgroundColor = UIColor.systemGray6
            sender.tintColor = UIColor.black
        }
    }
    @IBAction func ThursdayClicked(_ sender: UIButton) {
        if checkDay(weekday: 4) == 1 {
            sender.backgroundColor = UIColor.purple
            sender.tintColor = UIColor.white
        }
        else {
            sender.backgroundColor = UIColor.systemGray6
            sender.tintColor = UIColor.black
        }
    }
    @IBAction func FridayClicked(_ sender: UIButton) {
        if checkDay(weekday: 5) == 1 {
            sender.backgroundColor = UIColor.purple
            sender.tintColor = UIColor.white
        }
        else {
            sender.backgroundColor = UIColor.systemGray6
            sender.tintColor = UIColor.black
        }
    }
    @IBAction func SaturdayClicked(_ sender: UIButton) {
        if checkDay(weekday: 6) == 1 {
            sender.backgroundColor = UIColor.purple
            sender.tintColor = UIColor.white
        }
        else {
            sender.backgroundColor = UIColor.systemGray6
            sender.tintColor = UIColor.black
        }
    }
    
    /// When a day button clicked, value changed
    /// 1 == picked ; 0 == not picked
    func checkDay(weekday:Int) -> Int {
        if selectedWeekday[weekday] == 0 {
            selectedWeekday[weekday] = 1
        }
        else {
            selectedWeekday[weekday] = 0
        }
        return selectedWeekday[weekday]
    }
    
    func checkIfDaySelected() -> Int {
        for day in selectedWeekday {
            if day == 1 {
                return 1;
            }
        }
        return 0;
    }
    
    @IBAction func SetReminderAction(_ sender: Any) {
        if checkIfDaySelected() == 1 {
            /// Check if user have allowed notifications permission
            notifCenter.getNotificationSettings { settings in
                
                if settings.authorizationStatus != .authorized {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Notifications Permissions", message: "To use this feature, you need to allow notification permission.\nWould you like to allow it?", preferredStyle: .alert)

                        /// Open settings if user want to allow permissions
                        let yesAction = UIAlertAction(title: "Yes", style: .default) { action in
                            guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
                            else {
                                return
                            }
        
                            if(UIApplication.shared.canOpenURL(settingsURL)) {
                                UIApplication.shared.open(settingsURL) { (_) in
                                }
                            }
                        }
                        let noAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
        
                        alert.addAction(yesAction)
                        alert.addAction(noAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else {
                    for (index, weekday) in self.selectedWeekday.enumerated() {
                        if weekday == 1 {
                            self.setReminder(weekday: index+1)
                        }
                    }
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Choose a Day", message: "Pleas choose minimum 1 day to add the reminder", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func setReminder(weekday:Int) {
        /// Check if user have allowed notifications permission
        notifCenter.getNotificationSettings { settings in
            
            DispatchQueue.main.async {
                guard let delegate = self.reminderDelegate else { return }

                let time = self.timePicker.date
                
                let id = delegate.addNewReminder(day: DayOfWeek.allCases[weekday-1], time: time)

                if settings.authorizationStatus == .authorized {
                    
                    /// Set the content of notifications
                    let reminderContent = UNMutableNotificationContent()
                    reminderContent.title = "Hi parents, it's time for activity!"
                    reminderContent.body = "Don't forget to do activity with your child to make sure they get enough interaction"
                    reminderContent.sound = .default
                    
                    /// Set trigger "WHEN" to send the notifications
                    var reminderTime = Calendar.current.dateComponents([.hour, .minute], from: time)
                    reminderTime.weekday = weekday
                    let timeTrigger = UNCalendarNotificationTrigger(dateMatching: reminderTime, repeats: true)
                    
                    /// Send notifications request ke Notification Center
                    let request = UNNotificationRequest(identifier: id.uuidString, content: reminderContent, trigger: timeTrigger)
                    self.notifCenter.add(request, withCompletionHandler: nil)
                    
                }
                else {
                    
                    let alert = UIAlertController(title: "Notifications Permissions", message: "To use this feature, you need to allow notification permission.\nWould you like to allow it?", preferredStyle: .alert)

                    /// Open settings if user want to allow permissions
                    let yesAction = UIAlertAction(title: "Yes", style: .default) { action in
                        guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
                        else {
                            return
                        }
    
                        if(UIApplication.shared.canOpenURL(settingsURL)) {
                            UIApplication.shared.open(settingsURL) { (_) in
                            }
                        }
                    }
                    let noAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
    
                    alert.addAction(yesAction)
                    alert.addAction(noAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }
    }
}
