//
//  NavigationBar.swift
//  saasSwift
//
//  Created by 周玉 on 2017/11/20.
//  Copyright © 2017年 周玉. All rights reserved.
//

import UIKit

//自定义导航栏
class NavigationBar: UIView {
    //背景颜色
    var bgColor: String? = "#ffffff"

    override func draw(_ rect: CGRect) {
        let width : CGFloat = frame.size.width
        let height : CGFloat = frame.size.height
        
        //绘制nabbar
        let bezierPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width, height: height))
        //填充颜色
        guard let bgColor = bgColor else {
            return
        }
        UIColor.colorWithHexString(hexStr: bgColor).setFill()
        bezierPath.fill()
        
        //绘制底部灰色的线
//        let lineBottom : CGFloat = 1 / UIScreen.main.scale
//        let lineY : CGFloat = bounds.size.height - lineBottom
        let lineBezier = UIBezierPath()
        lineBezier.move(to: CGPoint(x: 0, y: height))
        lineBezier.addLine(to: CGPoint(x: width, y: height))
        UIColor.colorWithHexString(hexStr: "#d5d5d5").setStroke()
        lineBezier.stroke()
    }
}
