//
//  VisitorTableViewController.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/6.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit

class VisitorTableViewController: UITableViewController {
    //用户登录标记
    private var userLogon = false
    //访客视图
    var visitorView:VisitorView?
    
    
    override func loadView() {
        userLogon ? super.loadView() : setupVisitorView()
        //添加监听方法
        
    }
    
    private func setupVisitorView() {
        //替换根视图
        visitorView = VisitorView()
        
        view = visitorView
        //view.backgroundColor = UIColor.orange
        
        visitorView?.registerButton.addTarget(self, action:#selector(VisitorTableViewController.visitorViewDidRegister), for: UIControl.Event.touchUpInside)
        visitorView?.loginButton.addTarget(self, action: #selector(VisitorTableViewController.visitorViewDidLogin), for: UIControl.Event.touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

   

}

//访客视图监听方法
extension VisitorTableViewController {
    @objc func visitorViewDidRegister() {
        print("注册")
    }
    @objc func visitorViewDidLogin() {
        let vc = OAuthViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav,animated: true, completion: nil)
    }
    
    
    
}
