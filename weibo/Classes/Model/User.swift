//
//  User.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/12.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit
//用户模型
class User: NSObject {
 
    @objc var id: Int = 0
    //昵称
    @objc var screen_name:String?
    //头像
    @objc var profile_image_url:String?
    //认证类型
    @objc var verified_type: Int = 0
    //会员等级
    @objc var mbrank:Int = 0
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String { // 便于追踪
        let keys = ["id", "screen_name", "profile_image_url",
                    "verified_type", "mbrank"]
        return dictionaryWithValues(forKeys: keys).description
    }
    
   
    
}
