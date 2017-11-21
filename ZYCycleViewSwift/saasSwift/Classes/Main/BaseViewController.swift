//
//  BaseViewController.swift
//  saasSwift
//
//  Created by 周玉 on 2017/11/20.
//  Copyright © 2017年 周玉. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    //用来设置navBar的透明度
    var navBarAlpha : CGFloat? {
        didSet{
            navBar.alpha = navBarAlpha ?? 0
        }
    }
    
    //实际上是用来设置系统的tintColor
    var navBarTintColor : UIColor? {
        didSet{
            navigationController?.navigationBar.tintColor = navBarTintColor
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : navBarTintColor ?? "#ff0000"]
        }
    }
    
    //自定义导航栏
    lazy var navBar : NavigationBar = {
        let height : CGFloat = 44.0 + UIApplication.shared.statusBarFrame.size.height
        let navBar = NavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height))
        navBar.bgColor = "#efefef"
        view.addSubview(navBar)
        return navBar
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setUpNavBar()
         //导航栏默认透明度
        setNavBarAlpha(0.965)
    }
    
    // 控制器的view添加子控件的时候会调用
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //保证自定义nabBar始终在最前面
        view.bringSubview(toFront: navBar)
    }
}

//MARK: 设置nav的透明度
extension BaseViewController {
    open func setNavBarAlpha(_ navBarAlpha : CGFloat) {
        self.navBar.alpha = navBarAlpha
    }
}

//MARK: 修改系统的navBar的返回按钮
extension BaseViewController{
    
    fileprivate func setUpNavBar() {
        // 设置所有的控制器的返回按钮都为空字符串
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backItem")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backItem")
    }
}


















