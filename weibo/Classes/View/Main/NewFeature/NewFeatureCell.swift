//
//  NewFeatureCell.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/11.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit
import SnapKit

class NewFeatureCell: UICollectionViewCell {
    
   
    //fram的大小是Layout.itemSize 指定的
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        //添加控件
        addSubview(iconView)
        iconView.frame = bounds
        addSubview(startButton)
        
        //约束
        startButton.snp_makeConstraints { (make) ->Void in
            make.centerX.equalTo(self.snp_centerX)
            make.bottom.equalTo(self.snp_bottom).multipliedBy(0.7)
        }
        
        //监听方法
        startButton.addTarget(self, action: #selector(NewFeatureCell.clickStartButton), for: .touchUpInside)
        startButton.isHidden = true
        
    }
    
    @objc private func clickStartButton() {
        
        NotificationCenter.default.post (name: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification), object: nil)
    }
    
    
    //图片
    public lazy var iconView:UIImageView = UIImageView()
    //图像属性
     public var imageIndex: Int = 0 {
        didSet {
            
            
            iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
        }
        
    }
    
    /// 开始体验按钮
    public lazy var startButton: UIButton = UIButton(title: "开始体验", color:UIColor.white, backImageName: "new_feature_finish_button")
    
    //显示按钮动画
    
    public func showButtonAnim() {
      
        startButton.isHidden = false
        startButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        startButton.isUserInteractionEnabled = false
            
        UIView.animate(withDuration: 1.6,     // 动画时长
        delay: 0,                           // 延时时间
        usingSpringWithDamping: 0.6,    // 弹力系数，0~1，越小越弹
        initialSpringVelocity: 10,      // 初始速度，模拟重力加速度
        options: [],                       // 动画选项
        animations: { () -> Void in
                self.startButton.transform = CGAffineTransform.identity
            }) { (_) -> Void in
                self.startButton.isUserInteractionEnabled = true
            }
        
    }

  }
    

