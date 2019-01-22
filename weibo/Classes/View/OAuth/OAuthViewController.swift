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
        
        //加载页面
        self.webView.loadRequest(NSURLRequest(url:NetworkTools.sharedTools.OAuthURL as URL) as URLRequest)
        
        
    }
    
    override func loadView() {
        view = webView
        //设置代理
        webView.delegate = self
        
        //设置导航栏
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(OAuthViewController.close))
        
        //给导航栏添加右上角按钮 和相应方法
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style:.plain, target: self, action: #selector(OAuthViewController.autoFill))
    }
    
    @objc private func autoFill() {
        
        let js = "document.getElementById('userId').value = '350666080@qq.com';" + "document.getElementById('passwd').value = '00002121lhm';"
        
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

        // 4. 加载 accessToken
        UserAccountViewModel.sharedUserAccount.loadAccessToken(code: code) { (isSuccessed) -> () in
            // 如果失败，则直接返回
            if !isSuccessed {
               //如果失败 直接返回
                return
               
            }else {
                
                print("成功了")
                //用户登录成功 则退出当前控制器，并发送根视图
                self.dismiss(animated: false, completion: {
                    NotificationCenter.default.post (name: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification), object: "welcome")
                    
                })
            }
        }
       return false
    }
    
    
    //加载accessToken时调用该方法
    private func loadUserInfo(account: UserAccount) {
        NetworkTools.sharedTools.loadUserInfo(uid: account.uid!) { (result, error) in
            if error != nil {

                print("加载用户出错了")
                return

                guard let dict = result as? [String:AnyObject] else {

                    print("格式错误")

                    return
                }

               // print(dict["screen_name"])
               // print(dict["avatar_large"])
            }
        }
    }
    
    //加载accessToken
    
    
}


