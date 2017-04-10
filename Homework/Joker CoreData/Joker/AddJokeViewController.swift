//
//  AddJokeViewController.swift
//  Joker
//
//  Created by Nathan VelaBorja on 2/6/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class AddJokeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var Line1TextField: UITextField!
    @IBOutlet weak var Line2TextField: UITextField!
    @IBOutlet weak var Line3TextField: UITextField!
    @IBOutlet weak var AnswerTextField: UITextField!
    var nJokes = 0
    var savePressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleLabel.text = "Enter New Joke #\(nJokes + 1)"
        
        Line1TextField.delegate = self
        Line2TextField.delegate = self
        Line3TextField.delegate = self
        AnswerTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func cancelButtonDidTouchUpInside(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindFromAddJoke", sender: nil)
    }
    
    @IBAction func saveButtonDidTouchUpInside(_ sender: UIBarButtonItem) {
        self.savePressed = true
        performSegue(withIdentifier: "unwindFromAddJoke", sender: nil)
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
