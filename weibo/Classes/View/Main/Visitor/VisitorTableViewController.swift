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
    }
    
    private func setupVisitorView() {
        //替换根视图
        visitorView = VisitorView()
        
        view = visitorView
        //view.backgroundColor = UIColor.orange
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
