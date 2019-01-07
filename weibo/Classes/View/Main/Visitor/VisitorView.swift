//
//  VisitorView.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/6.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    //构造函数
    //使用纯代码开发使用
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //initWithFrame是UIview的指定构造函数
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    //懒加载控件
    //使用image：构造函数的imageView默认就是image的大小
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    private lazy var homeIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    private lazy var maskIconView:UIImageView=UIImageView(image:UIImage(named:"visitordiscover_feed_mask_smallicon"))
    //label按钮
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        //文字颜色
        label.textColor = UIColor.darkGray
        //字体号
        label.font = UIFont.systemFont(ofSize: 14)
        //文字不限行数
        label.numberOfLines = 0
        //对齐方式
        label.textAlignment = NSTextAlignment.center
        
        return label
    }()
    
    //注册按钮
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("注册", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)

        return button
    }()
    //登录按钮
    private lazy var loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("登录", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
       
        return button
    }()
    
    //开启首页转轮动画
    private func startAnim() {
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 20
        anim.isRemovedOnCompletion = false
        //添加到涂层
        iconView.layer.add(anim, forKey: nil)
        
    }
    
}

extension VisitorView{
    
    //设置界面
    private func setupUI() {
        addSubview(iconView)
        addSubview(homeIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        addSubview(maskIconView)
        
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints=false
        }
        
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))
        
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 224))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .left, relatedBy: .equal, toItem: messageLabel, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: messageLabel, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[mask]-0-|", options: [], metrics: nil, views: ["mask":maskIconView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mask]-(btnHeight)-[regButton]", options: [], metrics: ["btnHeight":-300], views: ["mask":maskIconView,"regButton":registerButton]))

        self.backgroundColor=UIColor(white: 237.0/255.0, alpha: 1.0)
        
    }
    
     func setupInfo(imageName:String?,title:String)
    {
        messageLabel.text = title
       // print(messageLabel.text)
        guard let imgName = imageName else{
            startAnim()
            return
        }
        iconView.image=UIImage(named:imgName)
        homeIconView.isHidden = true
        sendSubviewToBack(maskIconView)
    }

    
}
