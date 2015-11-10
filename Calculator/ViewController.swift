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
        
        //已經有按加減乘除的狀態，數字需要重新顯示
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
        
        //判斷是否已經包含負號("-")
        if (displayArea.text! as NSString).containsString("-"){
            displayArea.text = displayArea.text!.stringByReplacingOccurrencesOfString("-", withString: "")
        }else{
            displayArea.text = "-" + displayArea.text!
        }
    }
    
    //尚未完成
    @IBAction func percentBtn(sender: AnyObject) {
        guard displayArea.text! != "0" else{
            return
        }
        
        let strLength = displayArea.text?.characters.count
        //起始數字沒有"."
        if !displayArea.text!.characters.contains("."){
            if strLength < 3{
                if strLength == 1{
                    displayArea.text = "0.0" + displayArea.text!
                }else{
                    displayArea.text = "0." + displayArea.text!
                }
            }else{
                displayArea.text?.insert(".", atIndex: (displayArea.text?.endIndex.advancedBy(-2))!)
            }
        }else{
            //取得最後一個"."的位置
            let index = displayArea.text!.rangeOfString(".", options: .BackwardsSearch, range: nil, locale: nil)?.endIndex
            
            //加上正確"."該出現的地方
            
            if "\(index!)" == "2"{
                
                //如果"."在index 2的位置，則前面需補2個"0"
                //e.g. 1.2 -> 0.01.2
                displayArea.text = "0.0" + displayArea.text!
                
            }else if "\(index!)" == "3"{
                
                //如果"."在index 3的位置，則前面需補1個"0"
                //e.g. 12.3 -> 0.12.3
                displayArea.text = "0." + displayArea.text!
                
            }else{
                
                //e.g. 123.4 -> 1.23.4                
                displayArea.text!.insert(".", atIndex: index!.advancedBy(-3))
                
            }
            
            //拿掉最後一個"."
            let index1 = displayArea.text!.rangeOfString(".", options: .BackwardsSearch, range: nil, locale: nil)?.endIndex
            displayArea.text?.removeAtIndex(index1!.advancedBy(-1))
        }
        
        //判斷最後是否為"0"，是則拿掉
        let index = displayArea.text?.endIndex.advancedBy(-1)
        if displayArea.text![index!] == "0"{
            let range = displayArea.text!.endIndex.advancedBy(-1)..<displayArea.text!.endIndex
            displayArea.text?.removeRange(range)
            
            //再判斷最後是否為"0"，如果還是則拿掉"0"之外，也拿掉前面的"."
            let index1 = displayArea.text?.endIndex.advancedBy(-1)
            if displayArea.text![index1!] == "0"{
                let range = displayArea.text!.endIndex.advancedBy(-2)..<displayArea.text!.endIndex
                displayArea.text?.removeRange(range)
            }
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

