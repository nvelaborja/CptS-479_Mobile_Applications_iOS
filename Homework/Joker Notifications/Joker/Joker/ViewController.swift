//
//  ViewController.swift
//  Joker
//
//  Created by Nathan VelaBorja on 1/12/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    var line1 : String = ""
    var line2 : String = ""
    var line3 : String = ""
    var answer : String = ""
    var jokes : JokeArray = JokeArray()
    var notificationsAllowed : Bool = false
    var secondsLeft = 5
    var elapsedTime = 0.0
    var progressTimer : Timer = Timer()
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.text = ""
        
        initJokes()
        chooseJoke()
        
        // Make progress bar invisible until joke scheduling is successul
        progressBar.isHidden = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scheduleJokePressed(_ sender: UIButton) {
        if (!notificationsAllowed) {
            messageLabel.text = "Notifications disabled."
            return
        }
        
        messageLabel.text = "Joke scheduled for \(secondsLeft) seconds from now."
        scheduleJokeNotification()
        
        // Setup progress bar
        progressTimer.invalidate()
        progressBar.isHidden = false
        progressBar.setProgress(1.0, animated: false)
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: progressTimerTick)
    }
    
    // Randomly selects a joke from jokes array and set's app titles / answer to corresponding lines
    func chooseJoke() {
        
        if (jokes.jokes.count == 0){
            self.line1 = "No jokes!"
            self.line2 = ""
            self.line3 = ""
            self.answer = "No answers!"
            
            return
        }
        
        let randomJokeIndex = Int(arc4random_uniform(UInt32(self.jokes.jokes.count)))
        let joke = jokes.jokes[randomJokeIndex]
        
        self.line1 = joke.firstLine
        self.line2 = joke.secondLine
        self.line3 = joke.thirdLine
        self.answer = joke.answerLine
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ViewJokesSegue") {
            let jokeTableViewController = segue.destination as! JokeTableViewController
            jokeTableViewController.jokes = self.jokes
        }
    }
    
    func checkNotificationsSettings() {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings(completionHandler: self.handleNotificationSettings)
    }
    
    func handleNotificationSettings (notificationSettings: UNNotificationSettings) {
        if ((notificationSettings.alertSetting == .enabled) &&
            (notificationSettings.badgeSetting == .enabled) &&
            (notificationSettings.soundSetting == .enabled)) {
            self.notificationsAllowed = true
        } else {
            self.notificationsAllowed = false
        }
    }
    
    func handleJokeNotificationResponse(_ response: UNNotificationResponse) {
        let answer = response.notification.request.content.userInfo["answer"] as! String
    
        // Create an alert with joke answer
        let alert = UIAlertController(title: "Answer", message: answer, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
            // Clear message label
            self.messageLabel.text = ""
            
            // Hide progress bar
            self.progressBar.isHidden = true
            self.secondsLeft = 5
        }
        ))
        
        present(alert, animated: true, completion: nil)
    }
    
    func scheduleJokeNotification() {
        // First get a new joke
        chooseJoke()
        
        // Then build notification using joke content
        let content = UNMutableNotificationContent()
        content.title = "Here's your joke! Tap to see answer."
        content.body = "\(line1) \(line2) \(line3)"
        content.userInfo["answer"] = answer
        
        // Create trigger for 5 seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // Create request
        let request = UNNotificationRequest(identifier: "NowPlusFive", content: content, trigger: trigger)
        
        // Schedule request
        let center = UNUserNotificationCenter.current()
        center.add(request) {
            (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
    
    func progressTimerTick(timer: Timer) {
        elapsedTime += 0.1
        
        progressBar.setProgress(progressBar.progress - 0.02, animated: true)
        
        if (Int(elapsedTime + Double(secondsLeft)) > 5) {
            // Update progress members
            self.secondsLeft -= 1
            self.messageLabel.text = "Joke scheduled for \(self.secondsLeft) seconds from now."
        }
        
        if (elapsedTime > 5) {
            // Reset progress members
            progressTimer.invalidate()
            self.elapsedTime = 0.0
            self.secondsLeft = 5
            self.progressBar.setProgress(0.0, animated: true)
            
            // Make progressBar and message invisible
            messageLabel.text = ""
            progressBar.isHidden = true
        }
        else {
            // Restart timer
            progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: progressTimerTick)
        }
        
    }
}






