//
//  ReminderModel.swift
//  MC1-Group12
//
//  Created by Mohammad Alfarisi on 11/04/22.
//

import Foundation

typealias ReminderDict = [DayOfWeek: [Reminder]]

class ReminderModel {
   
    var reminders = [DayOfWeek.sunday: [Reminder(time: Date.now)]] {
        didSet {
            // Update to database
        }
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
    
    func addReminder(days: [DayOfWeek], time: Date) {
        
        // For each day of week
        for day in days {
            
            // Add new reminder to array
            let newReminder = Reminder(time: time)
            
            reminders[day]?.append(newReminder)
        }
    }
    
    func removeReminder(targetId: UUID) {
        
        // Check for every day of week
        for (_, var lists) in reminders {
            
            // Remove reminder with same id
            lists.removeAll(where: { (reminder) -> Bool in reminder.id == targetId } )
        }
    }
    
    func getReminders() {
        // Load reminders from db
        
        // If not found, set array as empty
    }
    
    func updateReminder(targetId: UUID, days: [DayOfWeek], time: Date) {
        
    }
}
