//
//  VisitorView.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/6.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit
import SnapKit


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
        label.text = "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜 "
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
    
//    //注册按钮
//    public lazy var registerButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("注册", for: .normal)
//        button.setTitleColor(UIColor.orange, for: .normal)
//        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
//
//        return button
//    }()
//    //登录按钮
//    public lazy var loginButton:UIButton = {
//        let button = UIButton()
//        button.setTitle("登录", for: .normal)
//        button.setTitleColor(UIColor.orange, for: .normal)
//        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
//
//        return button
//    }()
  
    public lazy var registerButton:UIButton=UIButton(title:"注册",color:UIColor.orange,backImageName:"common_button_white_disable")
    public lazy var loginButton:UIButton=UIButton(title:"登陆",color:UIColor.orange,backImageName:"common_button_white_disable")
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
        addSubview(maskIconView)
        addSubview(homeIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        //设置自动布局
        //图标
        iconView.snp_makeConstraints { (make) ->Void in
            make.centerX.equalTo(self.snp_centerX)
            make.centerY.equalTo(self.snp_centerY).offset(-60)
        }
        //房子
        homeIconView.snp_remakeConstraints { (make) ->Void in
            make.center.equalTo(iconView.snp_center)
        }
        //消息文字
        messageLabel.snp_makeConstraints { (make) ->Void in
            make.centerX.equalTo(iconView.snp_centerX)
            make.top.equalTo(iconView.snp_bottom).offset(16)
            make.width.equalTo(224)
            make.height.equalTo(36)
        }
        //注册按钮
        registerButton.snp_makeConstraints { (make) ->Void in
            make.left.equalTo(messageLabel.snp_left)
            make.top.equalTo(messageLabel.snp_bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        
        //登录按钮
        loginButton.snp_makeConstraints { (make) ->Void in
            make.right.equalTo(messageLabel.snp_right)
            make.top.equalTo(registerButton.snp_top)
            make.width.equalTo(registerButton.snp_width)
            make.height.equalTo(registerButton.snp_height)
        }
        
//        //遮照图像
        maskIconView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.bottom.equalTo(registerButton.snp_bottom)
        }

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
