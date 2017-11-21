
//
//  ZYLog.swift
//  saasSwift
//
//  Created by 周玉 on 2017/11/20.
//  Copyright © 2017年 周玉. All rights reserved.
//

import Foundation

//利用全局函数,自定义log
func ZYLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent):[第\(line)行], \(method): \n \(message)")
    #endif
}
