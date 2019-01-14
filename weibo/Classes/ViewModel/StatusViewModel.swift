//
//  StatusViewModel.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/13.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit

class StatusViewModel: CustomStringConvertible {
    
    //缩略图Url数组
    var thumbnailUrls: [NSURL]?
 
    //微博的模型
    var status:Status
    
    /// 用户头像 URL
    var userProfileUrl: NSURL {
        return NSURL(string: status.user?.profile_image_url ?? "")!
    }
    
    /// 用户默认头像
    var userDefaultIconView: UIImage {
        return UIImage(named: "avatar_default_big")!
    }
    
    /// 用户会员图标
    var userMemberImage: UIImage? {
        // 根据 mbrank 来生成图像
       
        if (status.user?.mbrank)! > 0 && (status.user?.mbrank)! < 7
        {
            return UIImage(named: "common_icon_membership_level\(status.user!.mbrank)")
        }
        return nil
    }
    
    /// 用户认证图标
    /// 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var userVipImage: UIImage? {
        switch(status.user?.verified_type ?? -1) {
        case 0: return UIImage(named: "avatar_vip")
        case 2, 3, 5: return UIImage(named: "avatar_enterprise_vip")
        case 220: return UIImage(named: "avatar_grassroot")
        default: return nil
        }
    }
    
    /// 行高
    lazy var rowHeight:CGFloat = {
       // print("计算缓存行高\(self.status.text)")
        let cell = StatusCell(style: .default, reuseIdentifier: StatusCellNormalId)
        //var cell:StatusCell
        //        if self.status.retweeted_status != nil{
        //            cell = StatusRetweetedCell(style:.default,reuseIdentifier:StatusCellRetweetedId)
        //        }else{
        //            cell = StatusNormalCell(style:.default,reuseIdentifier:StatusCellNormalId)
        //        }
        
        return cell.rowHeight(vm: self)
    }()
    
    //构造器
    init(status:Status) {
        self.status = status
        //根据模型，来生成缩略图数组
        if (status.pic_urls?.count)! > 0 {
            thumbnailUrls = [NSURL]()
            for dict in status.pic_urls! {
                let url = NSURL(string:dict["thumbnail_pic"]!)
                thumbnailUrls?.append(url!)
            }
        }
    }
    
    var description:String {
        
        return status.description + "配图数组 \(thumbnailUrls)"
    }
    
}
