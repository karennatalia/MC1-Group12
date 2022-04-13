//
//  ReminderModel.swift
//  MC1-Group12
//
//  Created by Mohammad Alfarisi on 11/04/22.
//

import Foundation

typealias ReminderDict = [DayOfWeek: [Reminder]]

class ReminderModel {
    
    private init() {}
    
    // Register as singleton
    static let instance = ReminderModel()
    
    // Mutable list of reminders
    private var _reminders = ReminderDict() {
        didSet {
            // TODO: update changes to UserDefaults
        }
    }
    
    // Dictionary of reminders with key as day and reminders array as value
    //
    // Immutable for access outside of model
    var reminders: ReminderDict {
        get { return _reminders }
    }
    
    // Array of days which has a reminder
    var reminderDays: [DayOfWeek] {
        get {
            var days = [DayOfWeek]()
            
            for day in DayOfWeek.allCases {
                if hasReminder(day: day) {
                    days.append(day)
                }
            }
            
            return days
        }
    }
    
    // Check if day has a reminder by validating if the day key is null
    // or if array is empty for that day
    //
    // Return true if reminder exist for given day
    func hasReminder(day: DayOfWeek) -> Bool {
        if reminders[day] == nil {
            return false
        }
        
        // If the array is not empty, return true
        return !reminders[day]!.isEmpty
    }
    
    func addReminder(day: DayOfWeek, time: Date) {
        
        // Add new reminder to array
        let newReminder = Reminder(time: time)
        
        // Get reminders for the day
        var newRemindersList = _reminders[day] ?? []
        
        // Append new reminder to list
        newRemindersList.append(newReminder)
        
        // Update key in dict
        _reminders.updateValue(newRemindersList, forKey: day)
    }
    
    func removeReminder(targetId: UUID) {
        
        // Check for every day of week
        for (_, var lists) in reminders {
            
            // Remove reminder with same id
            lists.removeAll(where: { (reminder) -> Bool in reminder.id == targetId } )
        }
    }
    
    // TODO: implement getting reminders from UserDefaults
    func getReminders() {
        // Load reminders from db
        
        // If not found, set array as empty
    }
    
    // TODO: implement
    func updateReminder(targetId: UUID, days: [DayOfWeek], time: Date) {
        
    }
}