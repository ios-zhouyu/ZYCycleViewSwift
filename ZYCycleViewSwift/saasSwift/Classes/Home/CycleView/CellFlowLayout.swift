//
//  CellFlowLayout.swift
//  saasSwift
//
//  Created by 周玉 on 2017/11/21.
//  Copyright © 2017年 周玉. All rights reserved.
//

import UIKit

class CellFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        //尺寸
        itemSize = (collectionView?.bounds.size)!
        //间距
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        //滚动方向
        scrollDirection = .horizontal
    }
}
