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
        
        request(method: .POST, URLString: urlString, parameters: params as [String : AnyObject], finished:
            finished)
    }
 
    
}
