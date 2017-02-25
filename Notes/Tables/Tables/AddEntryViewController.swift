//
//  AddEntryViewController.swift
//  Tables
//
//  Created by Nathan VelaBorja on 2/9/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var CancelButton: UIBarButtonItem!
    @IBOutlet weak var NameTextField: UITextField!
    
    var newCharacterReady: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        if (NameTextField.text!.isEmpty) {
            print("name empty")
        } else {
            self.newCharacterReady = true
        }
        performSegue(withIdentifier: "unwindFromAddEntry", sender: nil)
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
