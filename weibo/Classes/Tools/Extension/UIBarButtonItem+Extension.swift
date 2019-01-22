//
//  UIBarButtonItem+Extension.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/20.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName: String, target: AnyObject?, actionName: String?) {
        let button = UIButton(imageName: imageName, backImageName: nil)
        //判断actionName
        if let actionName = actionName {
            
            button.addTarget(target, action: Selector(actionName), for: .touchUpInside)
            
        }
        
        self.init(customView:button)
    }
}
