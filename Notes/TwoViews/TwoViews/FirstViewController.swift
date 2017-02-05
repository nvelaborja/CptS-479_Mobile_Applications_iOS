//
//  FirstViewController.swift
//  TwoViews
//
//  Created by Nathan VelaBorja on 1/31/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstViewLabel: UILabel!
    @IBOutlet weak var secondViewLabel: UILabel!
    @IBOutlet weak var firstViewText: UITextField!
    @IBOutlet weak var secondViewText: UITextField!
    @IBOutlet weak var secondViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func secondViewButtonTapped(_ sender: UIButton) {
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gotoSecondView") {
            let secondViewController = segue.destination as! SecondViewController
            secondViewController.firstViewText = self.firstViewText.text!
        }
    }
}

