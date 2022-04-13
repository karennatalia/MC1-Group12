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

    @IBOutlet weak var detailTitle: UITextView!
    @IBOutlet weak var detailAge: UIButton!
    @IBOutlet weak var detailPreparation: UIButton!
    @IBOutlet weak var detailDuration: UIButton!
    @IBOutlet weak var detailDesc: UITextView!
    @IBOutlet weak var detailReflect: UITextView!
    
    var selectedAct : ActivityClass!
    var nameActivity:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTitle.text = selectedAct.title
        detailAge.setTitle(selectedAct.age, for: .normal)
        detailPreparation.setTitle(selectedAct.preparation, for: .normal)
        detailDuration.setTitle(selectedAct.duration, for: .normal)
        detailDesc.text = selectedAct.description
        detailReflect.text = selectedAct.reflection
        
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
