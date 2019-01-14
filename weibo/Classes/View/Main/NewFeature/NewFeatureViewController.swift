//
//  NewFeatureViewController.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/10.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit
import SnapKit


private let reuseIdentifier = "Cell"

//可用单元格
private let WBNewFeatureViewCellId = "WBNewFeatureViewCellId"

class NewFeatureViewController: UICollectionViewController {
   
    //新特性图像的数量
    private let WBNewFeatureImageCount = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册可重用cell
        self.collectionView.register(NewFeatureCell.self, forCellWithReuseIdentifier: WBNewFeatureViewCellId)
        
    }

    init() {
        // super.指定的构造函数
        let layout = UICollectionViewFlowLayout()
        
        //设置每个单元格的尺寸
        layout.itemSize = UIScreen.main.bounds.size
        layout.minimumInteritemSpacing = 0     //设置单元格的间距为0
        layout.minimumLineSpacing = 0           //设置行间距为0
        layout.scrollDirection = .horizontal   //设置滚动方向是横向
        
        // 构造函数，完成之后内部属性才会被创建
        super.init(collectionViewLayout: layout)
        collectionView?.isPagingEnabled = true   //开启分页
        collectionView?.bounces = false         //去掉弹簧效果
        
        //去掉水平方向上的滚动条
        collectionView?.showsHorizontalScrollIndicator = false
    }
    //指定集合视图的布局参数
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    //集合视图中返回每个分组中，单元格的数量
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WBNewFeatureImageCount
    }
    
    // 返回每个单元格
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath/*单元格在集合视图中的位置*/) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WBNewFeatureViewCellId, for: indexPath) as! NewFeatureCell
        cell.imageIndex=indexPath.item
        return cell
    }
    
    //停止滚动方法
    // ScrollView 停止滚动方法
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // 在最后一页才调用动画方法
        // 根据 contentOffset 计算页数
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        // 判断是否是最后一页
        if page != WBNewFeatureImageCount - 1 {
            return
        }
        
        // Cell 播放动画
        let cell = collectionView?.cellForItem(
            at: NSIndexPath(item: page, section: 0) as IndexPath) as! NewFeatureCell
        
        // 显示动画
        cell.showButtonAnim()
    }
    
    
}
