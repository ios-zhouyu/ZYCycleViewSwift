//
//  SearchBar.swift
//  saasSwift
//
//  Created by 周玉 on 2017/11/20.
//  Copyright © 2017年 周玉. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    //必须实现加载SB/XIB的方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //遍历出文本框,进行自定义修改
    override func layoutSubviews() {
        backgroundImage = UIImage()
        backgroundColor = UIColor.clear
        for subView1 : UIView in subviews {
            for subView2 : UIView in subView1.subviews {
                if subView2.isKind(of: NSClassFromString("UISearchBarTextField")!) {
                    let textField = subView2 as! UITextField
                    textField.frame = CGRect(x: 10, y: 7, width: frame.size.width - 20, height: 30)
                    textField.font = UIFont.systemFont(ofSize: 14.0)
                    textField.setValue(UIColor.colorWithHexString(hexStr: "#ffffff"), forKeyPath: "_placeholderLabel.textColor")
                    textField.backgroundColor = UIColor.darkText.withAlphaComponent(0.2)
                    textField.layer.borderColor = UIColor.colorWithHexString(hexStr: "#b4b4b4").cgColor
                    textField.layer.borderWidth = 1.0;
                    textField.layer.cornerRadius = 15.0;
                    textField.layer.masksToBounds = true;
                }
            }
        }
        
    }
    
}
