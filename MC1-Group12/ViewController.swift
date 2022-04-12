//
//  ViewController.swift
//  MC1-Group12
//
//  Created by Karen Natalia on 07/04/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
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
        activityList = ActivitySeeder().generateActivity()
        getWelcomeTime()
        super.viewDidLoad()
        ActTableView?.delegate = self
        ActTableView.dataSource = self
        searchBar.delegate = self
        
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
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func toActivityDetails(_ sender: Any) {
        performSegue(withIdentifier: "toActivityDetail", sender: self)
    }
    
}
//
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredActList.count
        }
        return activityList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let actCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellAct") as! TableViewCell
        
        if isSearching {
            actCell.ActivityTitle?.text = filteredActList[indexPath.row].title
            actCell.ActivityAge?.text = filteredActList[indexPath.row].age
            actCell.ActivityDuration.setTitle(filteredActList[indexPath.row].duration, for: .normal)
            actCell.ActivityDuration.titleLabel?.font = UIFont(name: "SF Pro", size: 8)
            actCell.ActivityPreparation.setTitle(filteredActList[indexPath.row].preparation, for: .normal)
        } else {
            actCell.ActivityTitle?.text = activityList[indexPath.row].title
            actCell.ActivityAge?.text = activityList[indexPath.row].age
            actCell.ActivityDuration.setTitle(activityList[indexPath.row].duration, for: .normal)
            actCell.ActivityDuration.titleLabel?.font = UIFont(name: "SF Pro", size: 8)
            actCell.ActivityPreparation.setTitle(activityList[indexPath.row].preparation, for: .normal)
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
                tableViewDetail?.selectedAct = filteredActList[indexPath.row]
            } else {
                tableViewDetail?.selectedAct = activityList[indexPath.row]
            }
            
            self.ActTableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchtext", searchText)
        filteredActList = activityList.filter({$0.title.prefix(searchText.count) == searchText})
        print("filtered", filteredActList)
        isSearching = true
        ActTableView.reloadData()
    }
}
