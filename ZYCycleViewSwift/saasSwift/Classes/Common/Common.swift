
//
//  Common.swift
//  saasSwift
//
//  Created by 周玉 on 2017/11/20.
//  Copyright © 2017年 周玉. All rights reserved.
//

import Foundation
import UIKit

let KNavBarHeight : CGFloat = 44.0
let KStatusBarHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height
let KUIScreenHeight : CGFloat = UIScreen.main.bounds.size.height
let KUIScreenWidth : CGFloat = UIScreen.main.bounds.size.width
let KNavStausHeight : CGFloat = KNavBarHeight + KStatusBarHeight

//tableView,collectionView,scrollView的frame
let KUIDefaultFrame : CGRect = CGRect(x: 0, y: KNavStausHeight, width: KUIScreenWidth, height: KUIScreenHeight - KNavStausHeight)

//判断机型
let isIphone4 : Bool = (UIScreen.main.bounds.height == 480) //4/4s
let isIphone5 : Bool = (UIScreen.main.bounds.height == 568) //5/5s
let isIphone6 : Bool = (UIScreen.main.bounds.height == 667) //6/6s/7/7s/8
let isIphone6P : Bool = (UIScreen.main.bounds.height == 736) //6p/6sp/7p/7sp/8p
let isIphoneX : Bool = (UIScreen.main.bounds.height == 812) //X

