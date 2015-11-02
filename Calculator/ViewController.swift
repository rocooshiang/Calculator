//
//  ViewController.swift
//  Calculator
//
//  Created by Geosat-RD01 on 2015/10/31.
//  Copyright © 2015年 Geosat-RD01. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var symbol: UILabel!
    @IBOutlet var displayArea: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test pull request")
        print("test push")
        print("test merge")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func numberPointBtn(sender: AnyObject) {
        //小數點Button
        guard sender.tag! != 10 else{
            //如果displayArea尚未有小數點，則可以加入
            if !(displayArea.text! as NSString).containsString("."){
                displayArea.text = displayArea.text!+"."
            }
            return
        }
        
        //0 Buttno
        if sender.tag! == 0{
            //原始數字是0的話，按0就不做任何動作
            guard displayArea.text! != "0" else{
                return
            }
            displayArea.text = displayArea.text!+"0"
        }else{ // 1~9 Button
            displayArea.text = displayLabel(number: "\(sender.tag!)", displayArea: displayArea)
        }
    }
    
    @IBAction func addBtn(sender: AnyObject) {
    }
    
    @IBAction func subtractBtn(sender: AnyObject) {
    }
    
    @IBAction func multiplyBtn(sender: AnyObject) {
    }
    
    @IBAction func divideBtn(sender: AnyObject) {
    }
    
    @IBAction func totalBtn(sender: AnyObject) {
    }
    
    @IBAction func cleanBtn(sender: AnyObject) {
        displayArea.text = "0"
    }
    
    @IBAction func signBtn(sender: AnyObject) {
    }
    
    @IBAction func remainderBtn(sender: AnyObject) {
    }
    

    
}

