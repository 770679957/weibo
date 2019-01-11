//
//  UIImageView+Extension.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/11.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit
extension UIImageView {
    //遍历构造函数
    convenience init(imageName:String) {
        self.init(image:UIImage(named: imageName))
    }
    
}
