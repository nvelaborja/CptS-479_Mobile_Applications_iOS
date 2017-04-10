//
//  ViewEditJokeViewController.swift
//  Joker
//
//  Created by Nathan VelaBorja on 4/3/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class ViewEditJokeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var line1: UITextField!
    @IBOutlet weak var line2: UITextField!
    @IBOutlet weak var line3: UITextField!
    @IBOutlet weak var answer: UITextField!
    var save = false
    var oldLine1: String!
    var oldLine2: String!
    var oldLine3: String!
    var oldAnswer: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        line1.delegate = self
        line2.delegate = self
        line3.delegate = self
        answer.delegate = self

        // Start text fields at old values
        line1.text = oldLine1
        line2.text = oldLine2
        line3.text = oldLine3
        answer.text = oldAnswer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindFromEditJoke", sender: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        save = true
        performSegue(withIdentifier: "unwindFromEditJoke", sender: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
