//
//  ViewController.swift
//  Gestures
//
//  Created by Nathan VelaBorja on 2/28/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tapCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Programmatically add gesture
         let tapGestureRecognizer = UITapGenstureRecognizer(target: self, action: #selector(tapDetected))
         
         tapGestureRecognizer.delegate = self
         self.addGestureRecognizer(tapGestureRecognizer)
 
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Setup tap gesture action
    @IBAction func tapDetected (recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: self.view)
        let x1 = point.x
        let y1 = point.y
        messageLabel.text = "Tap detected at (\(x1), \(y1))"
        
        incrementTapCount()
    }
    
    func incrementTapCount() {
        let count = Int((tapCountLabel.text?.components(separatedBy: " ").last)!)
        
        tapCountLabel.text = "Tap Count: \(count! + 1)"
    }


}

