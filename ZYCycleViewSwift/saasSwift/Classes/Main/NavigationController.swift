//
//  NavigationController.swift
//  saasSwift
//
//  Created by 周玉 on 2017/11/20.
//  Copyright © 2017年 周玉. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置中间标题的颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black]
        
        //设置透明bar,自定义nabBar
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        //两侧按钮的渲染颜色
        navigationBar.tintColor = UIColor.colorWithHexString(hexStr: "#e7161a")
    }
}

extension NavigationController{
    override internal func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.view.backgroundColor = UIColor.white
        }
        super.pushViewController(viewController, animated: animated)
    }
}
