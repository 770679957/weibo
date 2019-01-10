//
//  NetworkTools.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/8.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit
import AFNetworking

//http请求方法枚举
enum HMRequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {
   
    //应用程序信息
    private let appKey = "2410496155"
    private let appSecret = "42f030373ec9c88c03b841da5742eddd"
    private let redirectUrl = "http://www.baidu.com"

    
    //网络请求完成回调
    typealias  HMRequestCallBack = (Any?,Error?)->()//新修改
    //单例
    static let sharedTools: NetworkTools = {
        
        let tools = NetworkTools(baseURL: nil)
        
        // 设置反序列化数据格式 - 系统会自动将 OC 框架中的 NSSet 转换成 Set
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()

}

extension NetworkTools {
    func request(method:HMRequestMethod,URLString:String,parameters:[String:AnyObject]?,finished:@escaping HMRequestCallBack)
    {
        let success={(task:URLSessionDataTask?,result:Any?)->() in finished(result,nil)}//新修改
        let failure={(task:URLSessionDataTask?,error:Error?)->() in finished(nil,error)}//新修改
        
        if method==HMRequestMethod.GET
        {
            get(URLString, parameters: parameters, progress: nil, success: success,failure:failure)
        }
        if method==HMRequestMethod.POST
        {
            //post(URLString, parameters: parameters, progress: nil, success: {(result,error) in finished(result,nil)},failure:{(result,error) in finished(result,nil)})
            post(URLString, parameters: parameters, progress: nil, success: success,failure:failure)
        }
    }
}

// MARK: - OAuth 相关方法
extension NetworkTools {
    
    var OAuthURL:NSURL {
        var urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUrl)"
        //https://api.weibo.com/oauth2/authorize?client_id=123050457758183&redirect_uri=http://www.example.com/response&response_type=code
        return NSURL(string:urlString)!
        
    }
    
    //加载AccessToken
    func loadAccessToken(code: String, finished: @escaping HMRequestCallBack) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let params = ["client_id": appKey,
                      "client_secret": appSecret,
                      "grant_type": "authorization_code",
                      "code": code,
                      "redirect_uri": redirectUrl]
        
        request(method: .POST, URLString: urlString, parameters: params as [String : AnyObject], finished: finished)
        
        
//        // 测试返回的数据内容
//        // 1> 设置相应数据格式是二进制的
//        responseSerializer = AFHTTPResponseSerializer()
//
//        // 2> 发起网络请求
//        post(urlString, parameters: params, success: { (_, result) -> Void in
//            // 将二进制数据转换成字符串
//            let json = NSString(data: result as! Data, encoding:String.Encoding.utf8.rawValue)
//                    print(json)
//        }, failure: nil)
//// Optional({"access_token":"2.00ziILYHPKMIdCea5a9f4f5es6tiGC","remind_in":"157679999","expires_in":157679999,"uid":"6917980397","isRealName":"true"})
        
 
    }
    
    //返回token字典
    private var tokenDict:[String:AnyObject]? {
        if let token = UserAccountViewModel.sharedUserAccount.account?.access_token {
            print(token)
            
            return ["access_token":token as AnyObject]
        }
       return nil
    }
    
}

// MARK: - 用户相关方法
extension NetworkTools {
    /// 加载用户信息
    ///
    /// - parameter uid:         uid
    /// - parameter finished:    完成回调
    func loadUserInfo(uid: String,finished:@escaping HMRequestCallBack) {
        //加载用户信息
        guard var params = tokenDict else {
            //f如果字典为空，通知调用方无效
            finished(nil,NSError(domain: "cn.itcast.error", code: -1001, userInfo: ["message":"token 为空"]))
            
            return
        }
        
        //处理网络参数
        let urlString = "https://api.weibo.com/2/users/show.json"
        print(uid)
        params["uid"] = uid as AnyObject
        request(method: .GET, URLString: urlString, parameters: params as [String : AnyObject], finished: finished)
    }
}


