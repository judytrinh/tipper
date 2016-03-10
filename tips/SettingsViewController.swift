//
//  SettingsViewController.swift
//  tips
//
//  Created by Judy Trinh on 3/7/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var defaultThemeControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func themeChanged(sender: AnyObject) {
        let color = defaultThemeControl.selectedSegmentIndex == 0 ? LightTheme.darkColor : DarkTheme.darkColor
        let white = UIColor.whiteColor()
        
        if defaultThemeControl.selectedSegmentIndex == 0 {
            doneButton.tintColor = color
            defaultThemeControl.tintColor = color
            defaultTipControl.tintColor = color
            themeLabel.textColor = color
            tipPercentLabel.textColor = color
            backgroundView.backgroundColor = white
        } else {
            doneButton.tintColor = white
            defaultThemeControl.tintColor = white
            defaultTipControl.tintColor = white
            themeLabel.textColor = white
            tipPercentLabel.textColor = white
            backgroundView.backgroundColor = color
        }
    }

    @IBAction func popSettingsView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        let defaults = NSUserDefaults.standardUserDefaults()
        let indexTip = defaults.integerForKey("defaultTipIndex")
        let indexTheme = defaults.integerForKey("defaultThemeIndex")
        defaultTipControl.selectedSegmentIndex = indexTip
        defaultThemeControl.selectedSegmentIndex = indexTheme
        
        let color = indexTheme == 0 ? LightTheme.darkColor : DarkTheme.darkColor
        let white = UIColor.whiteColor()

        if indexTheme == 0 {
            doneButton.tintColor = color
            defaultThemeControl.tintColor = color
            defaultTipControl.tintColor = color
            themeLabel.textColor = color
            tipPercentLabel.textColor = color
            backgroundView.backgroundColor = white
        } else {
            doneButton.tintColor = white
            defaultThemeControl.tintColor = white
            defaultTipControl.tintColor = white
            themeLabel.textColor = white
            tipPercentLabel.textColor = white
            backgroundView.backgroundColor = color
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: "defaultTipIndex")
        defaults.setInteger(defaultThemeControl.selectedSegmentIndex, forKey: "defaultThemeIndex")
        defaults.synchronize()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
