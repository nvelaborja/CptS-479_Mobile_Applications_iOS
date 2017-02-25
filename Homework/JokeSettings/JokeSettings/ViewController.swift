//
//  ViewController.swift
//  JokeSettings
//
//  Created by Nathan VelaBorja on 2/20/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Setting_SortBy: UILabel!
    @IBOutlet weak var Setting_Shuffle: UILabel!
    @IBOutlet weak var Setting_Name: UILabel!
    @IBOutlet weak var Setting_RestrictContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        displaySettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Refresh settings
        displaySettings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displaySettings() {
        var setting_SortBy = "Sort By: "
        var setting_Shuffle = "Shuffle: "
        var setting_Name = "Name: "
        var setting_RestrictContent = "Restrict Content: "
        
        // Access settings to adjust values
        if (UserDefaults.standard.object(forKey: "SortBy") != nil) {
            setting_SortBy += UserDefaults.standard.string(forKey: "SortBy")!
        } else {
            UserDefaults.standard.set("Rating", forKey: "SortBy")
            setting_SortBy += UserDefaults.standard.string(forKey: "SortBy")!
        }
        
        if (UserDefaults.standard.object(forKey: "Shuffle") != nil) {
            setting_Shuffle += UserDefaults.standard.string(forKey: "Shuffle")!
        } else {
            UserDefaults.standard.set("On", forKey: "Shuffle")
            setting_Shuffle += UserDefaults.standard.string(forKey: "Shuffle")!
        }
        
        if (UserDefaults.standard.object(forKey: "Name") != nil) {
            setting_Name += UserDefaults.standard.string(forKey: "Name")!
        }
        
        if (UserDefaults.standard.object(forKey: "RestrictContent") != nil) {
            let restrict = UserDefaults.standard.string(forKey: "RestrictContent")!
            setting_RestrictContent += (restrict == "0") ? "Off" : "On"
        }
        
        Setting_SortBy.text = setting_SortBy
        Setting_Shuffle.text = setting_Shuffle
        Setting_Name.text = setting_Name
        Setting_RestrictContent.text = setting_RestrictContent
    }

}

