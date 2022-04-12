//
//  ReminderViewController.swift
//  MC1-Group12
//
//  Created by Karen Natalia on 10/04/22.
//

import UIKit
import UserNotifications

class AddReminderViewController: UIViewController {

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

        // Do any additional setup after loading the view.
        print(selectedWeekday)
    }
 
    @IBAction func SundayBtn(_ sender: Any) {
        if checkDay(weekday: 0) == 1 {
            sundayBtnUI.setTitle("-", for: .normal)
        }
        else {
            sundayBtnUI.setTitle("S", for: .normal)
        }
    }
    @IBAction func MondayBtn(_ sender: Any) {
        if checkDay(weekday: 1) == 1 {
            mondayBtnUI.setTitle("-", for: .normal)
        }
        else {
            mondayBtnUI.setTitle("M", for: .normal)
        }
    }
    @IBAction func TuesdayBtn(_ sender: Any) {
        if checkDay(weekday: 2) == 1 {
            tuesdayBtnUI.setTitle("-", for: .normal)
        }
        else {
            tuesdayBtnUI.setTitle("T", for: .normal)
        }
    }
    @IBAction func WednesdayBtn(_ sender: Any) {
        if checkDay(weekday: 3) == 1 {
            wednesdayBtnUI.setTitle("-", for: .normal)
        }
        else {
            wednesdayBtnUI.setTitle("T", for: .normal)
        }
    }
    @IBAction func ThursdayBtn(_ sender: Any) {
        if checkDay(weekday: 4) == 1 {
            thursdayBtnUI.setTitle("-", for: .normal)
        }
        else {
            thursdayBtnUI.setTitle("T", for: .normal)
        }
    }
    @IBAction func FridayBtn(_ sender: Any) {
        if checkDay(weekday: 5) == 1 {
            fridayBtnUI.setTitle("-", for: .normal)
        }
        else {
            fridayBtnUI.setTitle("T", for: .normal)
        }
    }
    @IBAction func SaturdayBtn(_ sender: Any) {
        if checkDay(weekday: 6) == 1 {
            saturdayBtnUI.setTitle("-", for: .normal)
        }
        else {
            saturdayBtnUI.setTitle("T", for: .normal)
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
    
    @IBAction func SetReminderAction(_ sender: Any) {
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
                    self.performSegue(withIdentifier: "unwindToHome", sender: self)
                }
            }
        }
        
    }
    
    func setReminder(weekday:Int) {
        
        /// Check if user have allowed notifications permission
        notifCenter.getNotificationSettings { settings in
            
            DispatchQueue.main.async {
                let time = self.timePicker.date

                if settings.authorizationStatus == .authorized {
                    
                    /// Set the content of notifications
                    let reminderContent = UNMutableNotificationContent()
                    reminderContent.title = "Hi parents, it's time for activity!"
                    reminderContent.body = "Don't forget to do activity with your child to make sure they get enough interaction"
                    reminderContent.sound = .default
                    
                    /// Set trigger "WHEN" to send the notifications
                    var reminderTime = Calendar.current.dateComponents([.hour, .minute], from: time)
                    reminderTime.weekday = weekday
                    print(reminderTime)
                    let timeTrigger = UNCalendarNotificationTrigger(dateMatching: reminderTime, repeats: true)
                    
                    /// Send notifications request ke Notification Center
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: reminderContent, trigger: timeTrigger)
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
