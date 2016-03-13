//
//  TipViewController.swift
//  tips
//
//  Created by Judy Trinh on 3/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

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
        
        // Load defaults at the very beginning, set if none exist
        let defaults = NSUserDefaults.standardUserDefaults()

        if defaults.objectForKey("defaultTipIndex") != nil {
            setTheme(defaults.integerForKey("defaultTipIndex"))
        } else {
            defaults.setInteger(1, forKey: "defaultTipIndex")
            defaults.synchronize()
        }
        
        if defaults.objectForKey("defaultThemeIndex") != nil {
            setTheme(defaults.integerForKey("defaultThemeIndex"))
        } else {
            defaults.setInteger(0, forKey: "defaultThemeIndex")
            defaults.synchronize()
        }
        
        let lastTimeOpened = defaults.objectForKey("lastTimeOpened")
        let timeElapsed = NSDate().timeIntervalSinceDate(lastTimeOpened as! NSDate)
        if timeElapsed / 60 < 10 {
            billField.text = defaults.objectForKey("billAmount") as! String
        }
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "rememberBillAmount",
            name: UIApplicationWillTerminateNotification,
            object: nil
        )
    }
    
    func rememberBillAmount() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "billAmount")
        defaults.setObject(NSDate(), forKey: "lastTimeOpened")
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
    
    func setTheme(indexTheme: Int) {
        let lightColor = indexTheme == 0 ? LightTheme.lightColor : DarkTheme.lightColor
        let darkColor = indexTheme == 0 ? LightTheme.darkColor : DarkTheme.darkColor
        
        backgroundTop.backgroundColor = lightColor
        backgroundBottom.backgroundColor = darkColor
        billField.tintColor = darkColor
        billField.textColor = darkColor
        tipControl.tintColor = darkColor
        settingsButtonItem.tintColor = darkColor
    }
    
    func setTipPercentage(indexTip: Int) {
        tipControl.selectedSegmentIndex = indexTip
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load defaults from settings
        let defaults = NSUserDefaults.standardUserDefaults()
        let indexTip = defaults.integerForKey("defaultTipIndex")
        let indexTheme = defaults.integerForKey("defaultThemeIndex")
        
        setTipPercentage(indexTip)
        setTheme(indexTheme)
        
        // Recalculate tip and total based on new default
        onEditingChanged(billField)
        
        // Refocus text input when we come back to tip page
        billField.becomeFirstResponder()
    }
}

