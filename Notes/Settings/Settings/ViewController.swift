//
//  ViewController.swift
//  Settings
//
//  Created by Nathan VelaBorja on 2/14/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var VolumeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Setup volume setting
        if (UserDefaults.standard.object(forKey: "volume") != nil) {
            let volume = UserDefaults.standard.integer(forKey: "volume")
            VolumeLabel.text = "Volume: \(volume)"
        } else {
            VolumeLabel.text = "Volume: 10"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

