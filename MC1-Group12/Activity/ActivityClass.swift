//
//  ActivityzClass.swift
//  MC1-Group12
//
//  Created by Rizki Faris on 11/04/22.
//

import Foundation
import UIKit

struct ActivityClass {
    
    var id: String!
    var title: String!
    var description: String = ""
    var duration: String = ""
    var age: String = ""
    var preparation: String = ""
    var reflection: String = ""
    var image: String = ""
    var isDone: Bool = false
    
    public init(id: String, title: String, description: String, duration: String, age: String, preparation: String, reflection: String, image: String, isDone: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.duration = duration
        self.age = age
        self.preparation = preparation
        self.reflection = reflection
        self.image = image
        self.isDone = isDone
    }
}
