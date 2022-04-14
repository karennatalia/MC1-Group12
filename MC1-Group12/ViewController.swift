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
    
    //Var for filter
    var isFiltering = false
    var receivedDurationFilter:Int = 0
    var receivedPreparationFilter: String = ""
    
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
        print(receivedDurationFilter)
        filterActivity()
    }
    
    @IBAction func unwindFromFilter(_ sender: UIStoryboardSegue) {
        if sender.source is FilterPopUpViewController {
            if let senderVC = sender.source as? FilterPopUpViewController {
                receivedDurationFilter = senderVC.duration
                receivedPreparationFilter = senderVC.preparation
            }
            print(receivedPreparationFilter)
            filterActivity()
        }
    }
    
    func filterActivity() {
        filteredActList.removeAll()
        
        //Filter duration
        if receivedDurationFilter != 0 {
            for i in 0...activityList.count-1 {
                if Int(activityList[i].duration.replacingOccurrences(of: " min", with: "")) ?? 0 <= receivedDurationFilter && !filteredActList.contains(where: { $0.id == activityList[i].id }) {
                    filteredActList.append(activityList[i])
                }
            }
            isFiltering = true
            ActTableView.reloadData()
        }
        
        
        //Filter preparation
        if receivedPreparationFilter != "" {
            if filteredActList.count > 0 {
                var prepFilteredAct = [ActivityClass]()

                for i in 0...filteredActList.count-1 {
                    if filteredActList[i].preparation == receivedPreparationFilter && !prepFilteredAct.contains(where: { $0.id == filteredActList[i].id }) {
                        prepFilteredAct.append(filteredActList[i])
                    }
                }
                filteredActList = prepFilteredAct
                isFiltering = true
                ActTableView.reloadData()
            }
            else {
                for i in 0...activityList.count-1 {
                    if activityList[i].preparation == receivedPreparationFilter {
                        filteredActList.append(activityList[i])
                    }
                }

                isFiltering = true
                ActTableView.reloadData()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching || isFiltering {
            return filteredActList.count
        }
        return activityList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let actCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellAct") as! TableViewCell
        
        if isSearching || isFiltering {
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
            
            if isSearching || isFiltering {
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
        print("searchtext", searchText)
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
