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
    
    /// Register as singleton
    static let instance = ReminderModel()
    
    /// Mutable list of reminders
    private var _reminders = ReminderDict() {
        didSet {
            if let encodedReminders = try? JSONEncoder().encode(reminders) {
                print(reminders)
                
                UserDefaults.standard.set(encodedReminders, forKey: "remindersDict")
            }
        }
    }
    
    /// Dictionary of reminders with key as day and reminders array as value
    ///
    /// Immutable for access outside of model
    var reminders: ReminderDict {
        get { return _reminders }
    }
    
    /// Array of days which has a reminder
    var reminderDays: [DayOfWeek] {
        get {
            return DayOfWeek.allCases.filter { day in self.hasReminder(day: day) }
        }
    }
    
    /// Check if day has a reminder. Returns true if at least one reminder exist for given day
    func hasReminder(day: DayOfWeek) -> Bool {
        // Check if there are no entries for that day in dictionary
        guard let remindersList = reminders[day] else { return false }
        
        // If the array is not empty, return true
        return !remindersList.isEmpty
    }
    
    func addReminder(day: DayOfWeek, time: Date, weekday: Int) -> UUID {
        
        // Add new reminder to array
        let newReminder = Reminder(time: time, weekday: weekday)
        
        // Get reminders for the day
        var newRemindersList = _reminders[day] ?? []
        
        // Append new reminder to list
        newRemindersList.append(newReminder)
        // Update key in dict
        _reminders.updateValue(newRemindersList, forKey: day)
        
        return newReminder.id
    }
    
    func removeReminder(targetId: UUID) {
        
        // Check for every day of week
        for (day, var lists) in reminders {
            
            // Remove reminder with same id
            lists.removeAll(where: { reminder in reminder.id == targetId } )
            
            // Update key in dict
            _reminders.updateValue(lists, forKey: day)
        }
    }
    
    func getReminders() {
        // To restore struct from UserDefaults
        if let decodedData = UserDefaults.standard.object(forKey: "remindersDict") as? Data {
            if let decodedReminders = try? JSONDecoder().decode(ReminderDict.self, from: decodedData) {
                _reminders = decodedReminders
                
                return
            }
        }
        
        _reminders = ReminderDict()
    }
    
    // TODO: implement
    func updateReminder(targetId: UUID, day: DayOfWeek, time: Date) {
        // Get reminders for the day
        var newRemindersList = _reminders[day] ?? []
        
        // Change the time in the list
        let idx = newRemindersList.firstIndex(where: { reminder in reminder.id == targetId } )
        newRemindersList[idx!].time = time
        
        // Update key in dict
        _reminders.updateValue(newRemindersList, forKey: day)
    }
}
