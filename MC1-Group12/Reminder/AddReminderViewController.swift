//
//  AddReminderViewController.swift
//  MC1-Group12
//
//  Created by Karen Natalia on 11/04/22.
//

import UIKit

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
}
