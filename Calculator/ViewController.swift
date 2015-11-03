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
    var dNumFirst : NSDecimalNumber!
    var type = 0
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func numberPointBtn(sender: AnyObject) {
        
        if flag{
            displayArea.text = "0"
            flag = false
        }
        
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
    
    @IBAction func totalBtn(sender: AnyObject) {
        calculateSymbol()
        type = 0
        flag = false
        symbol.text = ""
    }
    
    @IBAction func CalculateSymbolBtn(sender: AnyObject) {
        
        if !flag{
            calculateSymbol()
        }
        
        switch sender.tag{
        case 1:
            symbol.text = "+"
        case 2:
            symbol.text = "-"
        case 3:
            symbol.text = "x"
        case 4:
            symbol.text = "/"
        default:
            print("This tag is not found")
        }
        dNumFirst = NSDecimalNumber(string: displayArea.text)
        type = sender.tag!
        flag = true
    }
    
    
    @IBAction func cleanBtn(sender: AnyObject) {
        symbol.text = ""
        displayArea.text = "0"
        type = 0
        flag = false
    }
    
    @IBAction func signBtn(sender: AnyObject) {
        
        guard displayArea.text! != "0" else{
            return
        }
        
        if (displayArea.text! as NSString).containsString("-"){
            displayArea.text = displayArea.text!.stringByReplacingOccurrencesOfString("-", withString: "")
        }else{
            displayArea.text = "-" + displayArea.text!
        }
    }
    
    @IBAction func percentBtn(sender: AnyObject) {
        guard displayArea.text! != "0" else{
            return
        }
        let strLength = displayArea.text?.characters.count
        
        if strLength < 3{
            if strLength == 1{
                displayArea.text = "0.0" + displayArea.text!
            }else{
                displayArea.text = "0." + displayArea.text!
            }
        }else{
            displayArea.text?.insert(".", atIndex: (displayArea.text?.endIndex.advancedBy(-2))!)
        }
        
        //判斷最後是否為零，是則拿掉
        
       let index = displayArea.text?.endIndex.advancedBy(-1)
        if displayArea.text![index!] == "0"{
            let range = displayArea.text!.endIndex.advancedBy(-1)..<displayArea.text!.endIndex
            displayArea.text?.removeRange(range)
        }
    }
    
    func calculateSymbol(){
        switch type{
        case 1:
            displayArea.text = "\(dNumFirst.decimalNumberByAdding(NSDecimalNumber(string: displayArea.text)))"
        case 2:
            displayArea.text = "\(dNumFirst.decimalNumberBySubtracting(NSDecimalNumber(string: displayArea.text)))"
        case 3:
            displayArea.text = "\(dNumFirst.decimalNumberByMultiplyingBy(NSDecimalNumber(string: displayArea.text)))"
        case 4:
            displayArea.text = "\(dNumFirst.decimalNumberByDividingBy(NSDecimalNumber(string: displayArea.text)))"
        default :
            print("This type is not found")
        }
    }
    
}

