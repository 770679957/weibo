//
//  Status.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/12.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit

//微博数据模型
class Status: NSObject{
    
    @objc var id:Int = 0
    //创建内容
    @objc var text:String?
    //时间
    @objc var created_at:String?
    //来源
    @objc var source:String?
    
    // 用户模型
    @objc  var user:User?
    @objc var pic_urls:[[String:String]]?
    @objc var retweeted_status:Status?
    
    
    init(dict: [String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
 
    override func setValue(_ value: Any?, forKey key: String) {
        //判断key 是否是user
        if key == "user" {

            if let dict = value as? [String:AnyObject] {
                //print(dict)
                user = User(dict: dict)
                //print(user?.screen_name)
            }

            return
        }
        super.setValue(value, forKey: key)
        
    }
 
    override var description: String {
        
        let keys = ["id", "text", "created_at", "source", "user","pic_urls"]
        return dictionaryWithValues(forKeys: keys).description
    }
    
    
}
