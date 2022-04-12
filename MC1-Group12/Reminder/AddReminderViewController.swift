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
    @IBOutlet weak var snapshotImage: UIImageView!
    
    @IBOutlet weak var addReminderTopConstraint: NSLayoutConstraint!
    
    let notifCenter = UNUserNotificationCenter.current()
    var selectedWeekday:[Int] = [0,0,0,0,0,0,0]
    var startingTopConstant:CGFloat = 0.0
    var defaultTopConstant:CGFloat = 0.0
    var topSafeArea:CGFloat = 0.0
    var bottomSafeArea:CGFloat = 0.0
    var snapshot:UIImage?
    var screenHeight:CGFloat = 0.0
    
    enum AddReminderViewState {
        case expanded
        case normal
    }
    var currentState:AddReminderViewState = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        snapshotImage.image = snapshot
        
        let grayTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGrayView(_:)))
        grayView.addGestureRecognizer(grayTapRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanGesture(recognizer:)))
        panGestureRecognizer.delaysTouchesBegan = false
        panGestureRecognizer.delaysTouchesEnded = false
        addReminderView.addGestureRecognizer(panGestureRecognizer)
        
        defaultTopConstant = addReminderTopConstraint.constant
        
        sundayBtnUI.layer.cornerRadius = 5
        mondayBtnUI.layer.cornerRadius = 5
        tuesdayBtnUI.layer.cornerRadius = 5
        wednesdayBtnUI.layer.cornerRadius = 5
        thursdayBtnUI.layer.cornerRadius = 5
        fridayBtnUI.layer.cornerRadius = 5
        saturdayBtnUI.layer.cornerRadius = 5
        
        let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first

        topSafeArea = (keyWindow?.safeAreaInsets.top)!
        
        let screenSize: CGRect = UIScreen.main.bounds
        screenHeight = screenSize.height
        
        addReminderTopConstraint.constant = screenHeight - topSafeArea
        grayView.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAddReminderView()
    }
    
    func showAddReminderView() {
        self.view.layoutIfNeeded()
        addReminderTopConstraint.constant = defaultTopConstant
        let showCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        showCard.addAnimations({
            self.grayView.alpha = 0.7
        })
        showCard.startAnimation()
    }
    
    func showFullAddReminderView() {
        self.view.layoutIfNeeded()
        addReminderTopConstraint.constant = topSafeArea
        let showFullCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        showFullCard.startAnimation()
    }
    
    func dismissAddReminderView() {
        self.view.layoutIfNeeded()
        addReminderTopConstraint.constant = screenHeight - topSafeArea
        let dismissCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        dismissCard.addAnimations({
            self.grayView.alpha = 0.0
        })
        dismissCard.addCompletion { position in
            if position == .end {
                if(self.presentingViewController != nil) {
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
        dismissCard.startAnimation()
    }
    
    @objc func didTapGrayView(_ sender: Any) {
        dismissAddReminderView()
    }
    
    @objc func didPanGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        switch recognizer.state {
            case .began:
            self.startingTopConstant = addReminderTopConstraint.constant
            case .changed:
                if self.startingTopConstant + translation.y > 30.0 {
                    self.addReminderTopConstraint.constant = self.startingTopConstant + translation.y
                }
            case .ended:
                if self.startingTopConstant + translation.y > defaultTopConstant {
                    dismissAddReminderView()
                }
                else if self.startingTopConstant == topSafeArea && translation.y > 0 {
                    showAddReminderView()
                }
                else {
                    showFullAddReminderView()
                }
            default:
                break
            }
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
