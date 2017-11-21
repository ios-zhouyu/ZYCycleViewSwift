//
//  CycleView.swift
//  saasSwift
//
//  Created by 周玉 on 2017/11/21.
//  Copyright © 2017年 周玉. All rights reserved.
//

import UIKit

//图片的模式
enum contentMode {
    case scaleAspectFill
    case scaleAspectFit
}

protocol CycleViewDelegate : class {
    func cycleViewDidSelectedItemAtIndex(_ index : NSInteger) -> ()
}

class CycleView: UIView,UICollectionViewDelegate, UICollectionViewDataSource {
    
    //代理
    weak var delegate : CycleViewDelegate?
    
    var mode : contentMode? = .scaleAspectFill

    //CollectionView复用cell的机制,不管当前的section有道少了item,当cell的宽和屏幕的宽一致是,当前屏幕最多显示两个cell(图片切换时是两个cell),切换完成时有且仅有一个cell,即使放大1000倍,内存中最多加载两个cell,所以不会造成内存暴涨现象
    let KCount = 100
    
    //MARK: 获取图片URL数组
    var imageURLStringArr : [String]? {
        didSet{
            pageControl.numberOfPages = (imageURLStringArr?.count)!
            collectionView.reloadData()
            //滚动到中间位置
            let indexPath : IndexPath = IndexPath(item: (imageURLStringArr?.count)! * KCount, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
    
    //MARK: 设置pageControl的颜色
    var pageColor : UIColor? {
        didSet{
            pageControl.pageIndicatorTintColor = pageColor
        }
    }
    var currentPageColor : UIColor? {
        didSet{
            pageControl.currentPageIndicatorTintColor = currentPageColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 懒加载子控件
    //collectionView
    lazy var collectionView : UICollectionView = {
        let layout : CellFlowLayout = CellFlowLayout()
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.bounces = false;
        collectionView.isPagingEnabled = true;
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.delegate = self as UICollectionViewDelegate
        collectionView.register(CycleCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    //指示器
    lazy var pageControl : UIPageControl = {
        let width : CGFloat = 120
        let height : CGFloat = 20
        let pointX : CGFloat = (UIScreen.main.bounds.size.width - width) * 0.5
        let pointY : CGFloat = bounds.size.height - height
        let pageControl = UIPageControl(frame: CGRect(x: pointX, y: pointY, width: width, height: height))
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = UIColor.lightText
        pageControl.currentPageIndicatorTintColor = UIColor.white
        return pageControl
    }()
    //定时器
    lazy var timer : Timer = {
        let timer = Timer(timeInterval: 2.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
        return timer
    }()
}

//MARK: 轮播逻辑处理
extension CycleView {
    //MARK: 更新定时器 获取当前位置,滚动到下一位置
    @objc func updateTimer() -> Void {
        let indexPath = collectionView.indexPathsForVisibleItems.last
        guard indexPath != nil else {
            return
        }
        let nextPath = IndexPath(item: (indexPath?.item)! + 1, section: (indexPath?.section)!)
        collectionView.scrollToItem(at: nextPath, at: .left, animated: true)
    }
    
    //MARK: 开始拖拽时,停止定时器
    internal func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.fireDate = Date.distantFuture
    }
    
    //MARK: 结束拖拽时,恢复定时器
    internal func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer.fireDate = Date(timeIntervalSinceNow: 2.0)
    }
    
    //MARK: 监听手动减速完成(停止滚动)  - 获取当前页码,滚动到下一页,如果当前页码是第一页,继续往下滚动,如果是最后一页回到第一页
    internal func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX : CGFloat = scrollView.contentOffset.x
        let page : NSInteger = NSInteger(offsetX / bounds.size.width)
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        if page == 0 { //第一页
            collectionView.contentOffset = CGPoint(x: offsetX + CGFloat((imageURLStringArr?.count)!) * CGFloat(KCount) * bounds.size.width, y: 0)
        } else if page == itemsCount - 1 { //最后一页
            collectionView.contentOffset = CGPoint(x: offsetX - CGFloat((imageURLStringArr?.count)!) * CGFloat(KCount) * bounds.size.width, y: 0)
        }
    }
    
    //MARK: 滚动动画结束的时候调用 - 获取当前页码,滚动到下一页,如果当前页码是第一页,继续往下滚动,如果是最后一页回到第一页
    internal func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(collectionView)
    }
    
    //MARK: 正在滚动(设置分页) -- 算出滚动位置,更新指示器
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        var page = NSInteger(offsetX / bounds.size.width + 0.5)
        page = page % (imageURLStringArr?.count)!
        pageControl.currentPage = page
    }

    //MARK: 随父控件的消失取消定时器
    internal override func removeFromSuperview() {
        super.removeFromSuperview()
        timer.invalidate()
    }
}

//MARK: 数据源和代理方法
extension CycleView {
    //FIXME: 点击cell的代理方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleViewDidSelectedItemAtIndex(indexPath.item % (imageURLStringArr?.count)!)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (imageURLStringArr?.count)! * 2 * KCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CycleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CycleCell
        cell.mode = mode
        cell.imageURLString = imageURLStringArr?[indexPath.item % (imageURLStringArr?.count)!] ?? ""
        return cell
    }
}

//MARK: 设置UI--轮播界面,指示器,定时器
extension CycleView {
    fileprivate func setUpUI() {
        addSubview(collectionView)
        addSubview(pageControl)
        //启动定时器
        timer.fireDate = Date(timeIntervalSinceNow: 2.0)
    }
}


