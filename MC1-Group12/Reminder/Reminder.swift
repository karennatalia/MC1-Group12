//
//  Reminder.swift
//  MC1-Group12
//
//  Created by Mohammad Alfarisi on 11/04/22.
//

import Foundation

struct Reminder : Identifiable, Encodable, Decodable {
    var id = UUID()
    var time: Date
    var weekday: Int
    var isEnabled: Bool = true
    
    var formattedTime: String {
        get {
            time.formatted(date: .omitted, time: .shortened)
        }
    }
}
