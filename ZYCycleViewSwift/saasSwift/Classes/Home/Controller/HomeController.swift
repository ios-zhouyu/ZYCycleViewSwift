//
//  HomeController.swift
//  saasSwift
//
//  Created by 周玉 on 2017/11/20.
//  Copyright © 2017年 周玉. All rights reserved.
//

import UIKit

class HomeController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CycleViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setSearchBar()
        //设置导航栏的初始透明度
        setNavBarAlpha(0.0)
    }

    @objc fileprivate func click() {
        navigationController?.pushViewController(SaasController(), animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}

//MARK: CycleViewDelegate
extension HomeController {
    func cycleViewDidSelectedItemAtIndex(_ index: NSInteger) {
        let demoVc = DemoController()
        demoVc.title = "点击了轮播图第\(index)个图片"
        demoVc.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(demoVc, animated: true)
    }
}

//MARK: 设置secton的头部标题
extension HomeController {
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UIView = UIView(frame: CGRect(x: 0, y: 0, width: KUIScreenWidth, height: 35.0))
        view.backgroundColor = UIColor.colorWithHexString(hexStr: "#eeeeee")
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: KUIScreenWidth / 2, height: view.frame.size.height))
        titleLabel.textColor = UIColor.colorWithHexString(hexStr: "#ff0000")
        titleLabel.font = UIFont.systemFont(ofSize: 15.0)
        
        if section ==  0 {
            
        } else if section == 1 {
            titleLabel.text = "    ▏招投标"
        } else if section == 2 {
            titleLabel.text = "    ▏竞比价"
        } else if section == 3 {
            titleLabel.text = "    ▏询价"
        } else if section == 4 {
            titleLabel.text = "    ▏单一来源"
        } else {
            titleLabel.text = "    ▏竞争性谈判"
        }
        
        let moreBtn = UIButton(frame: CGRect(x: KUIScreenWidth - 60, y: 0, width: 60, height: view.frame.size.height))
        moreBtn.setTitle("更多>>", for: .normal)
        moreBtn.setTitleColor(UIColor.darkGray, for: .normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        moreBtn.addTarget(self, action: #selector(moreInfo), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(moreBtn)
        return view
    }
    
    @objc fileprivate func moreInfo(sender : UIButton) {
        ZYLog("更多")
    }
}

//MARK: 导航栏渐变
extension HomeController {
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        var alpha = (offsetY) / 250
        if alpha < 0 {
            alpha = 0
        } else if alpha > 1 {
            alpha = 1
        }
        setNavBarAlpha(alpha)
    }
}

//MARK: 设置自定义搜索栏
extension HomeController {
    fileprivate func setSearchBar() {
        let searchBar = SearchBar(frame: CGRect(x: 10, y: KStatusBarHeight + 5, width: KUIScreenWidth - 20, height: 60))
        navigationItem.titleView = searchBar
        searchBar.placeholder = "搜索商品/服务"
        searchBar.delegate = self as UISearchBarDelegate;
    }
    
}

//MARK: 设置tableView
extension HomeController{
    fileprivate func setUpUI() {
        //tabbar的高度
        var tabBarHeight : CGFloat = 0
        if isIphoneX {
            tabBarHeight = 83
        } else {
            tabBarHeight = 49
        }
        
        let frame : CGRect = CGRect(x: 0, y: KNavStausHeight, width: KUIScreenWidth, height: KUIScreenHeight - KNavStausHeight - tabBarHeight)
        
        let tableView : UITableView = {
            let tableView = UITableView(frame: frame, style: .grouped)
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
            tableView.separatorStyle = .singleLine
            
//            tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.02))
//            tableView.tableHeaderView?.isHidden = true
            tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.02))
            tableView.tableFooterView?.isHidden = true
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 200
            
            if #available(iOS 11.0, *) {
                tableView.contentInsetAdjustmentBehavior = .never
            } else {
                automaticallyAdjustsScrollViewInsets = false
            }
            
            //轮播图加载
            let pointY = 44 + UIApplication.shared.statusBarFrame.size.height
            let cycleView : CycleView = CycleView(frame: CGRect(x: 0, y: pointY, width: UIScreen.main.bounds.size.width, height: 220))
            cycleView.delegate = self
            cycleView.mode = .scaleAspectFill
            //本地图片测试--加载网络图片,请用第三方库如SDWebImage等
            cycleView.imageURLStringArr = ["banner01.jpg", "banner02.jpg", "banner03.jpg", "banner04.jpg"]
            tableView.tableHeaderView = cycleView
            
            return tableView
        }()
        
        view.addSubview(tableView)
    }
}
/*
 [
 "http://www.wocoor.com/templates/images/banner01.jpg",
 "http://www.wocoor.com/templates/images/banner02.jpg",
 "http://www.wocoor.com/templates/images/banner03.jpg",
 "http://www.wocoor.com/templates/images/banner04.jpg"
 ]
 */

//MARK: 数据源和代理方法
extension HomeController{
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(SaasController(), animated: true)
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    //数据源方法
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1;
        } else {
            return 5
        }
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = "\(indexPath.section) + \(indexPath.row)"
        
        cell.selectionStyle = .gray
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}

//MARK: 设置section顶底部视图
extension HomeController {
    //section头部间距
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0
        } else {
            return 35.0
        }
    }
    //section头部视图
//    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: KUIScreenWidth, height: 1))
////        view.isHidden = true
//        view.backgroundColor = UIColor.clear
//        return view
//    }
    //section底部间距
    internal func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    //section底部视图
    internal func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KUIScreenWidth, height: 0.01))
        view.isHidden = true
        view.backgroundColor = UIColor.clear
        return view
    }
}
