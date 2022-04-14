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
                title: "Explain Like I’m 5!",
                description: "Explain the what you have to do for work or a concept that you are learning on the job to our child! Be sure to not use big or fancy words that they might not understand, stick to a simple vocabulary. It helps to ask them questions like “have you ever heard of …?” and “do you know about …?” . Once finished, ask our child to re-explain in their own words what you have told them! Through this activity, not only will our child have a better understanding of what you do they can also learn new concepts along the way!",
                duration: "10 min",
                age: "4 - 5 y.o",
                preparation: "Low",
                reflection: "- What questions do you have about the job? - What do they think about your job?",
                image: "explain_like_im_5.png",
                isDone: false
            ),
            ActivityClass(
                id: "2",
                title: "Simon Says!",
                description: "Simons Says is an activity where you give instruction to others with the sentence starting with “Simon Says”. Decide who will be the instruction giver and follower between you and your child. At first, you can start with simple instructions. After some time, you can experiment and gradually increase the instruction to be more complex. You can also incorporate some light physical activity within the instruction. \n \n Example: \"Simon says, close your eyes!\"\n \"Simon says, sing twinkle twinkle!\"\n \"Simon says, grab a toy!\"\n \"Simon says, jump as high as you can!\"",
                duration: "10 minutes",
                age: "2 - 4 y.o",
                preparation: "High",
                reflection: "- Which instruction in the most fun to do?\n- Which instruction do you think is the hardest?",
                image: "Simon_s_Says.png",
                isDone: false
            ),
            ActivityClass(
                id: "3",
                title: "Treasure Hunt!",
                description: "So pick up some items that you often use everyday, especially when our child is around example: pen, earphone, mask, glasses, water bottle, hat, etc.\n \n Ask our child to close their eyes and pick one item in front of them (without seeing it).\n \n With eyes still closed, ask them to guess what item is it, it’s okay if they have no clue. Whatever their answer is, ask them to open their eyes and give some responses by repeating their answer and add to it.\n \n Example:\n ‘Yes! You are right, it’s a pretty flower. The flower is bright red, and it smells good too!’\n ‘Oh, it’s not a baseball stick, it’s a pretty flower. The flower is bright red and it smells good right?’ \n \n You can also ask or tell them what is it for, and give responses as you’ve done before (as seen above). \n \n Pro Tip! \n You can pretend to give the wrong answer to provoke their response.",
                duration: "15 - 30 mins",
                age: "3 - 4 y.o",
                preparation: "Low",
                reflection: "- How do you feel right now? \n- Which item do you think is the most interesting? Why? \n- Which item do you think mom/dad often uses everyday? Ask them to explain more.",
                image: "Treasure_Hunt.png",
                isDone: false
            ),
            ActivityClass(
                id: "4",
                title: "Tell Me The Stories",
                description: "Take one or a few objects (random item/your childs toy) and create a story with the objects together with your child. For example, you take a spoon and a small plate, then play with the object to create a story. You could start with naming the object, “Hi, my name is plato and my name is spoony” then start to elaborate a random story together. It could be like love story, war story, castle story, or anything.",
                duration: "15-20 min",
                age: "2 - 5 y.o",
                preparation: "Low",
                reflection: "- How does the story end?\n- What lesson could you take from the story?",
                image: "Tell_me_your_stories.png",
                isDone: false
            ),
            ActivityClass(
                id: "5",
                title: "Shopping Toys on a Budget",
                description: "In this activity we will let our child to interact with other people. We and our child go to toys shop to buy new toys on a budget. We prepare IDR 100,000 and tell our child to shop any toys they want. We observe our child from a distance when our child shopping. Our child will interact with shopkeeper while finding the toys they want and pay them at cashier.",
                duration: "10 - 15 mins",
                age: "3 - 5 y.o",
                preparation: "High",
                reflection: "- How's it going ?\n- What do you buy ? \n- Why do you buy it ? \n- Do you like it ?",
                image: "Shopping.png",
                isDone: false
            )
        ]
    }
}
