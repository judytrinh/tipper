//
//  TipViewController.swift
//  tips
//
//  Created by Judy Trinh on 3/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

struct LightTheme {
    static var lightColor = UIColor(red: 255/255.0, green: 244/255.0, blue: 241/255.0, alpha: 1.0)
    static var darkColor = UIColor(red: 255/255.0, green: 97/255.0, blue: 136/255.0, alpha: 1.0)
}

struct DarkTheme {
    static var lightColor = UIColor(red: 237/255.0, green: 239/255.0, blue: 254/255.0, alpha: 1.0)
    static var darkColor = UIColor(red: 100/255.0, green: 78/255.0, blue: 151/255.0, alpha: 1.0)
}

class TipViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var backgroundTop: UIView!
    @IBOutlet weak var backgroundBottom: UIView!
    @IBOutlet weak var settingsButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        // Focus text input so keyboard automatically shows
        billField.becomeFirstResponder()
        
        // Set defaults at the very beginning
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(1, forKey: "defaultTipIndex")
        defaults.setInteger(0, forKey: "defaultThemeIndex")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Load defaults from settings
        let defaults = NSUserDefaults.standardUserDefaults()
        let indexTip = defaults.integerForKey("defaultTipIndex")
        let indexTheme = defaults.integerForKey("defaultThemeIndex")
        tipControl.selectedSegmentIndex = indexTip

        let lightColor = indexTheme == 0 ? LightTheme.lightColor : DarkTheme.lightColor
        let darkColor = indexTheme == 0 ? LightTheme.darkColor : DarkTheme.darkColor

        backgroundTop.backgroundColor = lightColor
        backgroundBottom.backgroundColor = darkColor
        billField.tintColor = darkColor
        billField.textColor = darkColor
        tipControl.tintColor = darkColor
        settingsButtonItem.tintColor = darkColor
        
        // Recalculate tip and total based on new default
        onEditingChanged(billField)
        
        // Refocus text input when we come back to tip page
        billField.becomeFirstResponder()
    }
}

