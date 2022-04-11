//
//  AddReminderViewController.swift
//  MC1-Group12
//
//  Created by Karen Natalia on 11/04/22.
//

import UIKit
import UserNotifications

class AddReminderViewController: UIViewController {

    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var addReminderView: CornerClass!
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

        let grayTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGrayView(_:)))
        grayView.addGestureRecognizer(grayTapRecognizer)
        
        sundayBtnUI.layer.cornerRadius = 5
        mondayBtnUI.layer.cornerRadius = 5
        tuesdayBtnUI.layer.cornerRadius = 5
        wednesdayBtnUI.layer.cornerRadius = 5
        thursdayBtnUI.layer.cornerRadius = 5
        fridayBtnUI.layer.cornerRadius = 5
        saturdayBtnUI.layer.cornerRadius = 5
    }
    
    @objc func didTapGrayView(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func SundayClicked(_ sender: Any) {
        if checkDay(weekday: 0) == 1 {
            sundayBtnUI.backgroundColor = UIColor.purple
            sundayBtnUI.setTitleColor(UIColor.green, for: .normal)
        }
        else {
            sundayBtnUI.backgroundColor = UIColor.systemGray4
            sundayBtnUI.setTitleColor(.black , for: .normal)
        }
    }
    @IBAction func MondayClicked(_ sender: Any) {
        if checkDay(weekday: 1) == 1 {
            mondayBtnUI.backgroundColor = UIColor.purple
            mondayBtnUI.setTitleColor(UIColor.green, for: .normal)
        }
        else {
            mondayBtnUI.backgroundColor = UIColor.systemGray4
            mondayBtnUI.setTitleColor(.black , for: .normal)
        }
    }
    @IBAction func TuesdayClicked(_ sender: Any) {
        if checkDay(weekday: 2) == 1 {
            tuesdayBtnUI.backgroundColor = UIColor.purple
            tuesdayBtnUI.setTitleColor(UIColor.green, for: .normal)
        }
        else {
            tuesdayBtnUI.backgroundColor = UIColor.systemGray4
            tuesdayBtnUI.setTitleColor(.black , for: .normal)
        }
    }
    @IBAction func WednesdayClicked(_ sender: Any) {
        if checkDay(weekday: 3) == 1 {
            wednesdayBtnUI.backgroundColor = UIColor.purple
            wednesdayBtnUI.setTitleColor(UIColor.green, for: .normal)
        }
        else {
            wednesdayBtnUI.backgroundColor = UIColor.systemGray4
            wednesdayBtnUI.setTitleColor(.black , for: .normal)
        }
    }
    @IBAction func ThursdayClicked(_ sender: Any) {
        if checkDay(weekday: 4) == 1 {
            thursdayBtnUI.backgroundColor = UIColor.purple
            thursdayBtnUI.setTitleColor(UIColor.green, for: .normal)
        }
        else {
            thursdayBtnUI.backgroundColor = UIColor.systemGray4
            thursdayBtnUI.setTitleColor(.black , for: .normal)
        }
    }
    @IBAction func FridayClicked(_ sender: Any) {
        if checkDay(weekday: 5) == 1 {
            fridayBtnUI.backgroundColor = UIColor.purple
            fridayBtnUI.setTitleColor(UIColor.green, for: .normal)
        }
        else {
            fridayBtnUI.backgroundColor = UIColor.systemGray4
            fridayBtnUI.setTitleColor(.black , for: .normal)
        }
    }
    @IBAction func SaturdayClicked(_ sender: Any) {
        if checkDay(weekday: 6) == 1 {
            saturdayBtnUI.backgroundColor = UIColor.purple
            saturdayBtnUI.setTitleColor(UIColor.green, for: .normal)
        }
        else {
            saturdayBtnUI.backgroundColor = UIColor.systemGray4
            saturdayBtnUI.setTitleColor(.black , for: .normal)
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
                    self.dismiss(animated: true)
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
