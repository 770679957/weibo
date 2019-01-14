//
//  HomeTableViewController.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/5.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit
import SVProgressHUD


/// 原创微博 Cell 的可重用表示符号
let StatusCellNormalId = "StatusCellNormalId"
/// 转发微博 Cell 的可重用标识符号
let StatusCellRetweetedId = "StatusCellRetweetedId"
class HomeTableViewController: VisitorTableViewController {
    
    
    
    //微博数据数组
   private lazy var listViewModel = StatusListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserAccountViewModel.sharedUserAccount.userLogon {
            visitorView?.setupInfo( imageName:nil, title:"关注一些人，回这里看看有什么惊喜")
            return
        }
        
        loadData()
        prepareTableView()
    }
    
    //准备表格
    private func prepareTableView() {
       //注册可重用单元格
        // 注册可重用 cell
        tableView.register(StatusCell.self,forCellReuseIdentifier:StatusCellNormalId)

        //预估行高
        tableView.estimatedRowHeight = 400
        //自动计算行高
        tableView.rowHeight = 400
        
        tableView.rowHeight = UITableView.automaticDimension
        //取消分割线
        tableView.separatorStyle = .none
        
        
    }
    
    //加载数据
    private func loadData() {
        
        listViewModel.loadStatus { (isSuccessed) ->() in
            if !isSuccessed {
                SVProgressHUD.showInfo(withStatus: "加载数据错误，请稍后再试")
                return
            }
            
            //刷新数据
            self.tableView.reloadData()
        }
    }

}

//数据源方法
extension HomeTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
       return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellNormalId, for: indexPath) as! StatusCell
        
        cell.viewModel = listViewModel.statusList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView:UITableView,heightForRowAt indexPath:IndexPath)->CGFloat {
//       //获得模型
//       let vm = listViewModel.statusList[indexPath.row]
//       let cell = StatusCell(style:.default, reuseIdentifier: StatusCellNormalId)
//        //返回行高
//        return cell.rowHeight(vm: vm)
        //p214
        return listViewModel.statusList[indexPath.row].rowHeight
    }
}
