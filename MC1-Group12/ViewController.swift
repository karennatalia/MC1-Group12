//
//  ViewController.swift
//  MC1-Group12
//
//  Created by Karen Natalia on 07/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    func getWelcomeTime() {
        let hour = Calendar.current.component(.hour, from: Date())
       
        switch hour {
            case 6..<12 :
            welcomeLabel.text = "Good " +  NSLocalizedString("Morning", comment: "Morning")
            case 12..<17 :
            welcomeLabel.text = "Good " +  NSLocalizedString("Afternoon", comment: "Afternoon")
            case 17..<22 :
            welcomeLabel.text = "Good " +  NSLocalizedString("Evening", comment: "Evening")
            default:
            welcomeLabel.text = "Good " +  NSLocalizedString("Night", comment: "Night")
        }
    }

    override func viewDidLoad() {
        getWelcomeTime()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

