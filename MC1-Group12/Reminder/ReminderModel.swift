//
//  ReminderModel.swift
//  MC1-Group12
//
//  Created by Mohammad Alfarisi on 11/04/22.
//

import Foundation

class ReminderModel {
    
    var reminders = [Reminder]() {
        didSet {
            // Update to database
        }
    }
    
    func addReminder(days: [DayOfWeek], time: Date) {
        
        // Add new reminder to array
        let newReminder = Reminder(time: time, days: days)
        
        reminders.append(newReminder)
    }
    
    func removeReminder(targetId: UUID) {
        
        // Remove all reminders with the target Id
        reminders.removeAll(where: {
            (reminder) -> Bool in reminder.id == targetId
        })
    }
    
    func getReminders() {
        // Load reminders from db
        
        // If not found, set array as empty
    }
    
    func updateReminder(targetId: UUID, days: [DayOfWeek], time: Date) {
        
        if let index = reminders.firstIndex(where: {
            (reminder) -> Bool in reminder.id == targetId
        }) {
            let newReminder = Reminder(id: targetId, time: time, days: days)
            
            reminders[index] = newReminder
        }
    }
}
