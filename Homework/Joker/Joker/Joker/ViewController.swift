//
//  ViewController.swift
//  Joker
//
//  Created by Nathan VelaBorja on 1/12/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var labelLine1: UILabel!
    @IBOutlet weak var labelLine2: UILabel!
    @IBOutlet weak var labelLine3: UILabel!
    @IBOutlet weak var answerOutlet: UILabel!
    @IBOutlet weak var answerButtonOutlet: UIButton!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    var jokes : JokeArray = JokeArray()
    var jokeIndex : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initJokes()
        chooseJoke()
        
        // Setup tap gesture recognizer for each star
        let star1Tap = UITapGestureRecognizer(target: self, action: #selector(handleStar1Tap(recognizer:)))
        star1Tap.delegate = self
        star1.isUserInteractionEnabled = true
        star1.addGestureRecognizer(star1Tap)
        
        let star2Tap = UITapGestureRecognizer(target: self, action: #selector(handleStar2Tap(recognizer:)))
        star2Tap.delegate = self
        star2.isUserInteractionEnabled = true
        star2.addGestureRecognizer(star2Tap)
        
        let star3Tap = UITapGestureRecognizer(target: self, action: #selector(handleStar3Tap(recognizer:)))
        star3Tap.delegate = self
        star3.isUserInteractionEnabled = true
        star3.addGestureRecognizer(star3Tap)
        
        let star4Tap = UITapGestureRecognizer(target: self, action: #selector(handleStar4Tap(recognizer:)))
        star4Tap.delegate = self
        star4.isUserInteractionEnabled = true
        star4.addGestureRecognizer(star4Tap)
        
        let star5Tap = UITapGestureRecognizer(target: self, action: #selector(handleStar5Tap(recognizer:)))
        star5Tap.delegate = self
        star5.isUserInteractionEnabled = true
        star5.addGestureRecognizer(star5Tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func answerTapped(_ sender: UIButton) {
        if (answerOutlet.isHidden){
            answerButtonOutlet.setTitle("Hide Joke", for: UIControlState.normal)
        }
        else {
            answerButtonOutlet.setTitle("Show Answer", for: UIControlState.normal)
            //chooseJoke()
        }
        
        answerOutlet.isHidden = !answerOutlet.isHidden
    }
    
    // Randomly selects a joke from jokes array and set's app titles / answer to corresponding lines
    func chooseJoke() {
        
        if (jokes.jokes.count == 0){
            self.labelLine1.text = "No jokes!"
            self.labelLine2.text = ""
            self.labelLine3.text = ""
            self.answerOutlet.text = "No answers!"
            
            return
        }
        
        //let randomJokeIndex = Int(arc4random_uniform(UInt32(self.jokes.jokes.count)))
        
        // If answer is shown, programmatically press the hide button
        if (!answerOutlet.isHidden) {
            answerTapped(answerButtonOutlet)
        }
        
        if (jokeIndex >= jokes.jokes.count) {
            jokeIndex = 0
        }
        else if (jokeIndex < 0) {
            jokeIndex = jokes.jokes.count - 1
        }
        let joke = jokes.jokes[jokeIndex]
        
        self.labelLine1.text = joke.firstLine
        self.labelLine2.text = joke.secondLine
        self.labelLine3.text = joke.thirdLine
        self.answerOutlet.text = joke.answerLine
        
        // Set title 
        navigationBar.title = "Joke \(jokeIndex + 1)"
        
        // Display stars for new joke
        setStars()
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
        self.jokes.jokes.append(joke)
    }
    
    @IBAction func AddJokeButtonDidTouchUpInside(_ sender: UIButton) {
        performSegue(withIdentifier: "AddJokeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ViewJokesSegue") {
            let jokeTableViewController = segue.destination as! JokeTableViewController
            jokeTableViewController.jokes = self.jokes
        }
    }
    
    // Gesture functions
    
    @IBAction func swipeDetected (recognizer: UISwipeGestureRecognizer) {
        
        switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirection.left:
            jokeIndex += 1
        case UISwipeGestureRecognizerDirection.right:
            jokeIndex -= 1
        default:
            break
        }
        
        chooseJoke()
    }
    
    func handleStar1Tap (recognizer: UITapGestureRecognizer) {
        print("Star 1 tapped")
        let currentJoke = self.jokes.jokes[jokeIndex]
        currentJoke.rating = 1
        setStars()
    }
    
    func handleStar2Tap (recognizer: UITapGestureRecognizer) {
        print("Star 2 tapped")
        let currentJoke = self.jokes.jokes[jokeIndex]
        currentJoke.rating = 2
        setStars()
    }
    
    func handleStar3Tap (recognizer: UITapGestureRecognizer) {
        print("Star 3 tapped")
        let currentJoke = self.jokes.jokes[jokeIndex]
        currentJoke.rating = 3
        setStars()
    }
    
    func handleStar4Tap (recognizer: UITapGestureRecognizer) {
        print("Star 4 tapped")
        let currentJoke = self.jokes.jokes[jokeIndex]
        currentJoke.rating = 4
        setStars()
    }
    
    func handleStar5Tap (recognizer: UITapGestureRecognizer) {
        print("Star 5 tapped")
        let currentJoke = self.jokes.jokes[jokeIndex]
        currentJoke.rating = 5
        setStars()
    }
    
    func setStars() {
        // Set star images based on joke rating
        let currentJoke = self.jokes.jokes[jokeIndex]
        star1.image = (currentJoke.rating > 0) ? #imageLiteral(resourceName: "Star_Filled") : #imageLiteral(resourceName: "Star_Hollow")
        star2.image = (currentJoke.rating > 1) ? #imageLiteral(resourceName: "Star_Filled") : #imageLiteral(resourceName: "Star_Hollow")
        star3.image = (currentJoke.rating > 2) ? #imageLiteral(resourceName: "Star_Filled") : #imageLiteral(resourceName: "Star_Hollow")
        star4.image = (currentJoke.rating > 3) ? #imageLiteral(resourceName: "Star_Filled") : #imageLiteral(resourceName: "Star_Hollow")
        star5.image = (currentJoke.rating > 4) ? #imageLiteral(resourceName: "Star_Filled") : #imageLiteral(resourceName: "Star_Hollow")
    }
}






