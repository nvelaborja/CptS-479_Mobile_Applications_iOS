//
//  SecondViewController.swift
//  TwoViews
//
//  Created by Nathan VelaBorja on 1/31/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var secondViewLabel: UILabel!
    @IBOutlet weak var firstViewLabel: UILabel!
    @IBOutlet weak var secondViewTextField: UITextField!
    @IBOutlet weak var firstViewTextField: UITextField!
    @IBOutlet weak var firstViewButton: UIButton!
    
    var firstViewText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstViewTextField.text = firstViewText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func firstViewButtonTapped(_ sender: UIButton) {
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
