//
//  FirstLaunchViewController.swift
//  MC1-Group12
//
//  Created by Anselmus Pavel Adriska on 12/04/22.
//

import UIKit

class FirstLaunchViewController: UIViewController {
    
    let userDefault = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if isNewUser() {
            setIsNotNewUser()
            performSegue(withIdentifier: "toOnboarding", sender: nil)
        } else {
            performSegue(withIdentifier: "toMain", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        let secondViewController = segue.destination as UIViewController
        secondViewController.modalPresentationStyle = .fullScreen
    }
    
    func isNewUser() -> Bool {
        return !userDefault.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        userDefault.set(true, forKey: "isNewUser")
    }
}
