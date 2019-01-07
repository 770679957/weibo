//
//  HomeTableViewController.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/5.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit

class HomeTableViewController: VisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView?.setupInfo( imageName:nil, title:"关注一些人，回这里看看有什么惊喜")

        
    }

   

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

   

}
