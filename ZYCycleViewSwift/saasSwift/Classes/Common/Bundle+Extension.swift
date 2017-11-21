
//
//  Bundle+Extension.swift
//  saasSwift
//
//  Created by 周玉 on 2017/11/20.
//  Copyright © 2017年 周玉. All rights reserved.
//

import Foundation

//获取命名空间
extension Bundle{
    // 计算型属性类似于函数，没有参数，有返回值
    var namespace: String{
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
