//
//  UIButton+Extension.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/6.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init (imageName: String, backImageName: String?) {
        self.init()
        //设置按钮图像
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        
        //设置按钮背景图像
        setBackgroundImage(UIImage(named: backImageName!), for: .normal)
        setBackgroundImage(UIImage(named: backImageName! + "_highlighted"), for: .highlighted)
        
        //根据背景图片的大小调整尺寸
        sizeToFit()
        
    }
    
    convenience init(title:String,color:UIColor,imageName:String) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setBackgroundImage(UIImage(named: imageName), for: .normal)
        
    }
    
    
}
