//
//  OAuthViewController.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/8.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {
    private lazy var webView = UIWebView()

    //监听方法
    @objc private func close() {
        
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = webView
        //设置代理
        webView.delegate = self
        
        //设置导航栏
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(OAuthViewController.close))
        //加载页面
        self.webView.loadRequest(NSURLRequest(url:NetworkTools.sharedTools.OAuthURL as URL) as URLRequest)
        
        //给导航栏添加右上角按钮 和相应方法
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style:.plain, target: self, action: #selector(OAuthViewController.autoFill))
    }
    
    @objc private func autoFill() {
        
        let js = "document.getElementById('userId').value = '350666080@qq.com';" + "document.getElementById('passwd').value = '';"
        
        webView.stringByEvaluatingJavaScript(from: js)
    }
    
    
    
    
    
    
    
    
    
}

extension OAuthViewController: UIWebViewDelegate {
    
    /// 将要加载请求的代理方法
    /// - parameter webView:        webView
    /// - parameter request:        将要加载的请求
    /// - parameter navigationType: 页面跳转的方式
    /// - returns: 返回 false 不加载，返回 true 继续加载
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool
    {
        
        guard let url=request.url,url.host == "www.baidu.com" else
        {
            return true
        }
        guard let query=url.query , query.hasPrefix("code=") else
        {
            print("取消授权")
            return false
        }
        let code=query.substring(from: "code=".endIndex)
        print("授权码是url:"+(request.url?.absoluteString)!)
        print("授权码是query:"+query)
        print("授权码是"+code)
//        UserAccountViewModel.sharedUserAccount.loadAccessToken(code: code){
//            (isSuccessed)->() in
//            if !isSuccessed
//            {
//                return
//            }
//            print("成功了")
//            self.dismiss(animated: false){
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification), object: "welcome")
//            }
//        }
        //加载accessToken
        NetworkTools.sharedTools.loadAccessToken(code: code) {
            (result, error) ->() in
            if error != nil {
                //print("\(error)")
                print("出错了")
                return
            }

            print(result)
        }
        
       return false
    }
    
}
