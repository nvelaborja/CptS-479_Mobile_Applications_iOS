//
//  SettingsViewController.swift
//  Bounce
//
//  Created by Nathan VelaBorja on 4/15/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var sfxSwitch: UISwitch!
    @IBOutlet weak var musicSwitch: UISwitch!
    var sfxOn: Bool!
    var musicOn: Bool!
    var vc: GameViewController!
    
    @IBAction func sfxValueChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "sfx")
    }
    
    @IBAction func musicValueChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "music")
        if (sender.isOn == false) {
            // Turn off game music
            vc.currentScene.pauseBackgroundMusic()
        }
        else {
            if !vc.currentScene.stopped {
                vc.currentScene.playBackgroundMusic()
            }
        }
        
        print(String(vc.currentScene.isHidden))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sfxSwitch.setOn(sfxOn, animated: true)
        musicSwitch.setOn(musicOn, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(_ sender: UIButton) {
        // Note: Storyboard won't let me create a regular unwind segue, dismiss for now to achieve the same affect
        dismiss(animated: true, completion: nil)
        print("done pressed")
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
