//
//  ViewController.swift
//  Joker
//
//  Created by Nathan VelaBorja on 1/12/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelLine1: UILabel!
    @IBOutlet weak var labelLine2: UILabel!
    @IBOutlet weak var labelLine3: UILabel!
    @IBOutlet weak var answerOutlet: UILabel!
    @IBOutlet weak var answerButtonOutlet: UIButton!
    var jokes : [Joke] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initJokes()
        chooseJoke()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func answerTapped(_ sender: UIButton) {
        answerOutlet.isHidden = !answerOutlet.isHidden
        
        if (!answerOutlet.isHidden){
            answerButtonOutlet.setTitle("New Joke", for: .normal)
        }
        else {
            chooseJoke()
            answerButtonOutlet.setTitle("Show Answer", for: .normal)
        }
    }
    
    // Randomly selects a joke from jokes array and set's app titles / answer to corresponding lines
    func chooseJoke() {
        let randomJokeIndex = Int(arc4random_uniform(UInt32(self.jokes.count)))
        let joke = jokes[randomJokeIndex]
        
        self.labelLine1.text = joke.firstLine
        self.labelLine2.text = joke.secondLine
        self.labelLine3.text = joke.thirdLine
        self.answerOutlet.text = joke.answerLine
    }
    
    // Initializes a series of jokese. Calls addJoke() for each joke
    func initJokes() {
        addJoke("What is blue", "and smells like", "red paint?", "Blue paint.")
        addJoke("Why do communists", "only write in", "lowercase?", "They hate Capitalism.")
        addJoke("What is going", "to replace", "Obamacare?", "DonTCare.")
        addJoke("What do you", "call bears with", "no ears?", "B.")
        addJoke("What did the", "two apples have", "in common?", "They were both apples.")
    }
    
    // Creates joke given joke parameters and adds joke to joke array
    func addJoke(_ first: String = "", _ second: String = "", _ third: String = "", _ answer: String = "") {
        let joke = Joke(first, second, third, answer)
        self.jokes.append(joke)
    }
}






