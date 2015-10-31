//
//  Global.swift
//  Calculator
//
//  Created by Geosat-RD01 on 2015/10/31.
//  Copyright © 2015年 Geosat-RD01. All rights reserved.
//

import Foundation
import UIKit

func displayLabel(number num: String,displayArea: UILabel)->String{
    var reStr : String!
    if num == "0"{
        if displayArea.text! != "0"{
           reStr = displayArea.text!+"0"
        }
    }else{
        if displayArea.text! != "0"{
            reStr = displayArea.text! + num
        }else{
            reStr = num
        }
    }
    return reStr
}

