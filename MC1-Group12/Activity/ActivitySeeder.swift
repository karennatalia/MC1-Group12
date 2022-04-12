//
//  ActivitySeeder.swift
//  MC1-Group12
//
//  Created by Rizki Faris on 11/04/22.
//

import Foundation
import UIKit

class ActivitySeeder {

    func generateActivity() -> [ActivityClass] {
        return [
            ActivityClass(
                id: "1",
                title: "Gardening Time",
                description: "Desc",
                duration: "15 min",
                age: "3 - 5 y.o",
                preparation: "Low",
                reflection: "Do your child like gardening time?",
                image: UIImage(),
                isDone: false
            ),
            ActivityClass(
                id: "2",
                title: "Cooking",
                description: "Desc",
                duration: "25 min",
                age: "3 - 5 y.o",
                preparation: "High",
                reflection: "Do your child like to cook?",
                image: UIImage(),
                isDone: false
            ),
            ActivityClass(
                id: "3",
                title: "Treasure Hunt!",
                description: "Desc",
                duration: "20 min",
                age: "2 y.o",
                preparation: "Low",
                reflection: "Do your child like find it interesting? what's your child expression after found the treasure?",
                image: UIImage(),
                isDone: false
            ),
            ActivityClass(
                id: "4",
                title: "Paper Plane",
                description: "Create a paper plane",
                duration: "15 min",
                age: "3 - 5 y.o",
                preparation: "High",
                reflection: "Do your child like to cook?",
                image: UIImage(),
                isDone: false
            )
        ]
    }
}
