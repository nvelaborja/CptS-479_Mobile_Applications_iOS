//
//  ViewController.swift
//  Commenter
//
//  Created by Nathan VelaBorja on 1/31/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var Button_Add: UIButton!
    var comments : [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        commentTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    @IBAction func ButtonAddTap(_ sender: UIButton) {
        // First check to see if comment text field is empty
        if (commentTextField.text == "") {
            return
        }
        
        // If there is a comment, we need to add it to our list
        let newComment = Comment(commentTextField.text!, Date())
        comments.append(newComment)
        
        // Finally, clear the text field
        commentTextField.text = "";
    }
    
    @IBAction func ButtonPrintAllTap(_ sender: UIButton) {
        print("***** Comment Log *****")
        for comment in comments {
            print("\(comment.date) : \(comment.comment)")
        }
        print("***********************")
    }

}

