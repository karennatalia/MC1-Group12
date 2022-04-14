//
//  ActivityDetailsViewController.swift
//  MC1-Group12
//
//  Created by Robby Suliantoro on 11/04/22.
//

import Foundation
import UIKit

class ActivityDetailsViewController: UIViewController {
    
    @IBOutlet weak var vwContainer2:UIView!

    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var detailTitle: UITextView!
    @IBOutlet weak var detailAge: UILabel!
    @IBOutlet weak var detailDuration: UILabel!
    @IBOutlet weak var detailPreparation: UILabel!
    
    @IBOutlet weak var detailDesc: UITextView!
    @IBOutlet weak var detailReflect: UITextView!
    
    @IBOutlet weak var detailImage: UIImageView!
    
    var selectedAct : ActivityClass!
    var nameActivity:String!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var resetButtonLine: UIView!
    
    func changeStatusDone(stat:Bool) {
        doneButton.isEnabled = !stat
        selectedAct.isDone = stat
        var defaultIsDone2 = userDefaults.object(forKey: "defaultIsDone") as! [Bool]
        
        let theId: Int = Int(selectedAct.id) ?? 1
        defaultIsDone2[theId - 1] = stat
        
        userDefaults.set(defaultIsDone2, forKey: "defaultIsDone")
        resetButton.isHidden = !stat
        resetButtonLine.isHidden = !stat
    }
    
    @IBAction func onPressDone(_ sender: UIButton) {
        changeStatusDone(stat: true)
    }
    
    @IBAction func onPressReset(_ sender: UIButton) {
        changeStatusDone(stat: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTitle.text = selectedAct.title
        detailAge.text = selectedAct.age
        detailPreparation.text = selectedAct.preparation
        detailDuration.text = selectedAct.duration
        detailDesc.text = selectedAct.description
        detailReflect.text = selectedAct.reflection
        detailImage.image = UIImage(named: selectedAct.image) 
        
        let defaultIsDone2 = userDefaults.object(forKey: "defaultIsDone") as! [Bool]
        
        let theId: Int = Int(selectedAct.id) ?? 1
        
        if defaultIsDone2[theId - 1] == true {
            doneButton.isEnabled = false
            resetButton.isHidden = false
            resetButtonLine.isHidden = false
        } else {
            doneButton.isEnabled = true
            resetButton.isHidden = true
            resetButtonLine.isHidden = true
        }
        
        // Do any additional setup after loading the view.
        
        
        vwContainer2.layer.shadowColor = UIColor.black.cgColor
        vwContainer2.layer.shadowOffset = .zero
        vwContainer2.layer.shadowOpacity = 0.5
        vwContainer2.layer.shadowRadius = 15
        vwContainer2.layer.shadowPath = UIBezierPath(rect: vwContainer2.bounds).cgPath
        vwContainer2.layer.shouldRasterize = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
