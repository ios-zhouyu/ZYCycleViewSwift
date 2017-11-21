//
//  TabBarController.swift
//  saasSwift
//
//  Created by 周玉 on 2017/11/20.
//  Copyright © 2017年 周玉. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setChildrenControllers()
    }
}

extension TabBarController{
    
    fileprivate func setChildrenControllers() {
        //沙盒加载json
        let docStr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docStr as NSString).appendingPathComponent("main.json")
        var data = NSData(contentsOfFile: jsonPath)
        
        //如果沙盒中没有main.json,从本地加载
        if data == nil{
            
            //获取值为nil的问题: 项目-->Build Phases-->copy Bundle Resource中没有加入此文件
            let filePath = Bundle.main.path(forResource: "main", ofType: "json")
            data = NSData(contentsOfFile: filePath!)
        }
        
        //
        guard let arr = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as?  [[String : AnyObject]]
            else {
                return
        }
        
        var arrM = [UIViewController]()
        for dict in arr! {
            arrM.append(childrenController(dict: dict as [String : AnyObject]))
        }
        viewControllers = arrM
    }
    
    //使用字典加载控制器
    fileprivate func childrenController(dict: [String : AnyObject]) -> UIViewController {
        
        //取得内容
        guard let RootVcName = dict["RootVcName"] as? String,
            let TabbarTitle = dict["TabbarTitle"] as? String,
            let NorImgName = dict["NorImgName"] as? String,
            let SellectImgName = dict["SellectImgName"] as? String,
            let RootVc = NSClassFromString(Bundle.main.namespace + "." + RootVcName) as? BaseViewController.Type
            else {
                return UIViewController()
        }

        //创建控制器视图
        let rootVc = RootVc.init()
        rootVc.title = TabbarTitle
        rootVc.tabBarController?.tabBarItem.title = TabbarTitle
        rootVc.view.backgroundColor = UIColor.white
        
        //设置图片
        rootVc.tabBarItem.image = UIImage(named:NorImgName)
        rootVc.tabBarItem.selectedImage = UIImage(named:SellectImgName)?.withRenderingMode(.alwaysOriginal)
        
        //设置tabbar标题字体
        ///: 'NSForegroundColorAttributeName' has been renamed to 'NSAttributedStringKey.foregroundColor'
        ///Cannot convert value of type 'NSAttributedStringKey' to expected argument type '[NSAttributedStringKey : Any]?'
        rootVc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], for: .selected)
        /// 'NSFontAttributeName' has been renamed to 'NSAttributedStringKey.font'
        rootVc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 11.0)], for: .normal)
        
        //实例化导航控制器
        let nav = NavigationController(rootViewController: rootVc)
        return nav
    }
    
}
