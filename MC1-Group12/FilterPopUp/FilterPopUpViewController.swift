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
    var duration = 0
    var preparation = ""
    var status = ""
//    var ages = [Int]()
    
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
                //cek apakah ada yg true di selectedduration
                var selectedIndex = -1
                if selectedDuration.contains(where: { $0 == true }) {
                    selectedIndex = selectedDuration.firstIndex(where: { $0 == true })!
                }
                //jika ada jadikan false
                if selectedIndex > -1 {
                    selectedDuration[selectedIndex] = false
                    //ubah appearance btn nya
                    durationButtons[selectedIndex].backgroundColor = UIColor.systemGray6
                    durationButtons[selectedIndex].tintColor = UIColor.black
                }
                    
                if selectedIndex != index {
                    selectedDuration[index] = !selectedDuration[index]
                    
                    if selectedDuration[index] {
                        durationButtons[index].backgroundColor = UIColor.purple
                        durationButtons[index].tintColor = UIColor.white
                    } else {
                        durationButtons[index].backgroundColor = UIColor.systemGray6
                        durationButtons[index].tintColor = UIColor.black
                    }
                }
            
            
            case "preparation":
                var selectedIndex = -1
                if selectedPreparation.contains(where: { $0 == true }) {
                    selectedIndex = selectedPreparation.firstIndex(where: { $0 == true })!
                }
                if selectedIndex > -1 {
                    selectedPreparation[selectedIndex] = false
                    //ubah appearance btn nya
                    preparationButtons[selectedIndex].backgroundColor = UIColor.systemGray6
                    preparationButtons[selectedIndex].tintColor = UIColor.black
                }
                
                if selectedIndex != index {
                    selectedPreparation[index] = !selectedPreparation[index]
                    
                    if selectedPreparation[index] {
                        preparationButtons[index].backgroundColor = UIColor.purple
                        preparationButtons[index].tintColor = UIColor.white
                    } else {
                        preparationButtons[index].backgroundColor = UIColor.systemGray6
                        preparationButtons[index].tintColor = UIColor.black
                    }
                }
            
            
            case "status":
                var selectedIndex = -1
                if selectedStatus.contains(where: { $0 == true }) {
                    selectedIndex = selectedStatus.firstIndex(where: { $0 == true })!
                }
                
                if selectedIndex > -1 {
                    selectedStatus[selectedIndex] = false
                    //ubah appearance btn nya
                    statusButtons[selectedIndex].backgroundColor = UIColor.systemGray6
                    statusButtons[selectedIndex].tintColor = UIColor.black
                }
                
                if selectedIndex != index {
                    selectedStatus[index] = !selectedStatus[index]
                    
                    if selectedStatus[index] {
                        statusButtons[index].backgroundColor = UIColor.purple
                        statusButtons[index].tintColor = UIColor.white
                    } else {
                        statusButtons[index].backgroundColor = UIColor.systemGray6
                        statusButtons[index].tintColor = UIColor.black
                    }
                }
            
            
            default:
                return
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let browserPageController = segue.destination as! ViewController
//        var duration = 0
//        var preparation = [String]()
//        var status = [Bool]()
//
        //get selected duration
        for i in 0...selectedDuration.count-1 {
            if selectedDuration[i] {
                duration = (i+1)*5
            }
        }
//
//        //get selected preparation
        if selectedPreparation[0] {
            preparation = "Low"
        } else if selectedPreparation[1] {
            preparation = "High"
        }
//
//        //get selected status
        if selectedStatus[0] {
            status = "Not Done"
        } else if selectedStatus[1] {
            status = "Done"
        }
        
            //get selected age
//        for i in 0...selectedAge.count-1 {
//            if selectedAge[i] { ages.append(i+1) }
//        }
//
//        browserPageController.receivedDurationFilter = duration
//        browserPageController.receivedPreparationFilter = preparation
//        browserPageController.receivedStatusFilter = status
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
}
