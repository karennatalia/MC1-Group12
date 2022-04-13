//
//  FilterPopUpViewController.swift
//  MC1-Group12
//
//  Created by Anselmus Pavel Adriska on 12/04/22.
//

import UIKit

class FilterPopUpViewController: UIViewController {
    
    @IBOutlet weak var age1Btn: UIButton!
    @IBOutlet weak var age2Btn: UIButton!
    @IBOutlet weak var age3Btn: UIButton!
    @IBOutlet weak var age4Btn: UIButton!
    @IBOutlet weak var age5Btn: UIButton!
    
    @IBOutlet weak var duration5Btn: UIButton!
    @IBOutlet weak var duration10Btn: UIButton!
    @IBOutlet weak var duration15Btn: UIButton!
    @IBOutlet weak var duration20Btn: UIButton!
    @IBOutlet weak var duration25Btn: UIButton!
    @IBOutlet weak var duration30Btn: UIButton!
    
    @IBOutlet weak var prepLowBtn: UIButton!
    @IBOutlet weak var prepHighBtn: UIButton!

    @IBOutlet weak var activityNotDoneBtn: UIButton!
    @IBOutlet weak var activityDoneBtn: UIButton!

    @IBOutlet weak var applyBtn: UIButton!
    
    var selectedAge = [false, false, false, false, false]
    var selectedDuration = [false, false, false, false, false, false]
    var selectedPreparation = [false, false]
    var selectedStatus = [false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons: [UIButton] = [age1Btn, age2Btn, age3Btn, age4Btn, age5Btn, duration5Btn, duration10Btn, duration15Btn, duration20Btn, duration25Btn, duration30Btn, prepLowBtn, prepHighBtn, activityNotDoneBtn, activityDoneBtn]
        // Do any additional setup after loading the view.
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            
            presentationController.prefersGrabberVisible = true
        }
        
        setBtnCornerRadius(buttons: buttons)
    }
    
    func setBtnCornerRadius(buttons: [UIButton]) {
        for btn in buttons {
            btn.layer.cornerRadius = 5
        }
    }
    
    func buttonSelected(buttonCategory: String, index: Int) {
        let ageButtons: [UIButton] = [age1Btn, age2Btn, age3Btn, age4Btn, age5Btn]
        let durationButtons: [UIButton] = [duration5Btn, duration10Btn, duration15Btn, duration20Btn, duration25Btn, duration30Btn]
        let preparationButtons: [UIButton] = [prepLowBtn, prepHighBtn]
        let statusButtons: [UIButton] = [activityNotDoneBtn, activityDoneBtn]
        
        switch buttonCategory {
            case "age":
                selectedAge[index] = !selectedAge[index]
                
                if selectedAge[index] {
                    ageButtons[index].backgroundColor = UIColor.purple
                    ageButtons[index].tintColor = UIColor.white
                } else {
                    ageButtons[index].backgroundColor = UIColor.systemGray6
                    ageButtons[index].tintColor = UIColor.black
                }
            
            case "duration":
                selectedDuration[index] = !selectedDuration[index]
                
                if selectedDuration[index] {
                    durationButtons[index].backgroundColor = UIColor.purple
                    durationButtons[index].tintColor = UIColor.white
                } else {
                    durationButtons[index].backgroundColor = UIColor.systemGray6
                    durationButtons[index].tintColor = UIColor.black
                }
                
            case "preparation":
                selectedPreparation[index] = !selectedPreparation[index]
                
                if selectedPreparation[index] {
                    preparationButtons[index].backgroundColor = UIColor.purple
                    preparationButtons[index].tintColor = UIColor.white
                } else {
                    preparationButtons[index].backgroundColor = UIColor.systemGray6
                    preparationButtons[index].tintColor = UIColor.black
                }
            
            case "status":
                selectedStatus[index] = !selectedStatus[index]
                
                if selectedStatus[index] {
                    statusButtons[index].backgroundColor = UIColor.purple
                    statusButtons[index].tintColor = UIColor.white
                } else {
                    statusButtons[index].backgroundColor = UIColor.systemGray6
                    statusButtons[index].tintColor = UIColor.black
                }
            
            default:
                return
        }
    }
    
    
    // ------------------------ IBAction
    @IBAction func btnAge1Clicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "age", index: 0)
    }
    
    @IBAction func btnAge2Clicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "age", index: 1)
    }
    
    @IBAction func btnAge3Clicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "age", index: 2)
    }
    
    @IBAction func btnAge4Clicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "age", index: 3)
    }
    
    @IBAction func btnAge5Clicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "age", index: 4)
    }
    
    @IBAction func btnDuration5Clicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "duration", index: 0)
    }
    
    @IBAction func btnDuration10Clicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "duration", index: 1)
    }
    
    @IBAction func btnDuration15Clicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "duration", index: 2)
    }
    
    @IBAction func btnDuration20Clicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "duration", index: 3)
    }
    
    @IBAction func btnDuration25Clicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "duration", index: 4)
    }
    
    @IBAction func btnDuration30Clicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "duration", index: 5)
    }
    
    @IBAction func btnPrepLowClicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "preparation", index: 0)
    }
    
    @IBAction func btnPrepHighClicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "preparation", index: 1)
    }
    
    @IBAction func btnStatusNotDoneClicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "status", index: 0)
    }
    
    @IBAction func btnStatusDoneClicked(_ sender: UIButton) {
        buttonSelected(buttonCategory: "status", index: 1)
    }
    
    @IBAction func applyBtnClicked(_ sender: UIButton) {
        
    }
}
