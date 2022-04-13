//
//  ViewController.swift
//  MC1-Group12
//
//  Created by Karen Natalia on 07/04/22.
//////

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var vwContainer:UIView!
    
    @IBOutlet weak var ActTableView: UITableView!
    
    var activityList = [ActivityClass]()
    var filteredActList = [ActivityClass]()
    var isSearching = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    func getWelcomeTime() {
        let hour = Calendar.current.component(.hour, from: Date())
       
        switch hour {
            case 6..<12 :
            welcomeLabel.text = "Good " +  NSLocalizedString("Morning", comment: "Morning")
            case 12..<15 :
            welcomeLabel.text = "Good " +  NSLocalizedString("Afternoon", comment: "Afternoon")
            case 15..<18 :
            welcomeLabel.text = "Good " +  NSLocalizedString("Evening", comment: "Evening")
            default:
            welcomeLabel.text = "Good " +  NSLocalizedString("Night", comment: "Night")
        }
    }

    let notifCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        activityList = ActivitySeeder().generateActivity()
        getWelcomeTime()
        super.viewDidLoad()
        ActTableView?.delegate = self
        ActTableView.dataSource = self
        searchBar.delegate = self
        
        vwContainer.layer.shadowColor = UIColor.black.cgColor
        vwContainer.layer.shadowOffset = .zero
        vwContainer.layer.shadowOpacity = 0.5
        vwContainer.layer.shadowRadius = 15
        vwContainer.layer.shadowPath = UIBezierPath(rect: vwContainer.bounds).cgPath
        vwContainer.layer.shouldRasterize = true
        
        // Do any additional setup after loading the view.
        notifCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted == true {
                print("Permission Granted")
            }
            else {
                print("Permission Not Granted")
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func toActivityDetails(_ sender: Any) {
        performSegue(withIdentifier: "toActivityDetail", sender: self)
    }
    
}
//
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching {
            return filteredActList.count
        }
        return activityList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let actCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellAct") as! TableViewCell
        
        if isSearching {
            actCell.ActivityTitle?.text = filteredActList[indexPath.section].title
            actCell.ActivityAge?.text = filteredActList[indexPath.section].age
            actCell.ActivityDuration.setTitle(filteredActList[indexPath.section].duration, for: .normal)
            actCell.ActivityDuration.titleLabel?.font = UIFont(name: "SF Pro", size: 8)
            actCell.ActivityPreparation.setTitle(filteredActList[indexPath.section].preparation, for: .normal)
        } else {
            actCell.ActivityTitle?.text = activityList[indexPath.section].title
            actCell.ActivityAge?.text = activityList[indexPath.section].age
            actCell.ActivityDuration.setTitle(activityList[indexPath.section].duration, for: .normal)
            actCell.ActivityDuration.titleLabel?.font = UIFont(name: "SF Pro", size: 8)
            actCell.ActivityPreparation.setTitle(activityList[indexPath.section].preparation, for: .normal)
        }
        return actCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toActivityDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toActivityDetail" {
            let indexPath = self.ActTableView.indexPathForSelectedRow!
            let tableViewDetail = segue.destination as? ActivityDetailsViewController
            
            if isSearching {
                tableViewDetail?.selectedAct = filteredActList[indexPath.section]
            } else {
                tableViewDetail?.selectedAct = activityList[indexPath.section]
            }
            
            self.ActTableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredActList = activityList.filter({$0.title.prefix(searchText.count) == searchText})
        filteredActList = activityList.filter { text in
            return text.title.lowercased().contains(searchText.lowercased())
        }
        if filteredActList.count == 0 && searchText == "" {
            filteredActList = activityList
        }
        isSearching = true
        ActTableView.reloadData()
    }
}
