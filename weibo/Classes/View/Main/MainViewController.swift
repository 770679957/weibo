//
//  MainViewController.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/5.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
        
    }
    
    //懒加载控件
    private lazy var composedButton: UIButton = UIButton(imageName: "tabbar_compose_icon_add", backImageName: "babbat_compose_button")
    //设置撰写按钮
    private func setupComposedButton() {
        //添加按钮
        tabBar.addSubview(composedButton)
        //调整按钮
        let count = children.count
        //解决手指触摸的容差问题
        let w = tabBar.bounds.width / CGFloat(count) - 1
        //composedButton.frame = CGRectInset(tabBar.bounds,2 * w, 0)
        composedButton.frame = CGRect(x: w * 2, y: 0, width: w, height: tabBar.bounds.height)
        
        composedButton.addTarget(self, action: #selector(clickComposedButton), for: .touchUpInside)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //创建tabbar中的所有控制器对应的按钮
        super.viewWillAppear(animated)
        //将撰写按钮移动到最前面
        tabBar.bringSubviewToFront(composedButton)
        
        setupComposedButton()
        
    }
    
    @objc private func clickComposedButton() {
        
        print("99999999")
    }

    
    

}

//设置界面
extension MainViewController {
    //添加所有控制器
    private func addChildViewControllers() {
        tabBar.tintColor = UIColor.orange
        addChildViewController(vc:HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(vc: MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        //添加空视图控制器
        addChild(UIViewController())
        addChildViewController(vc: DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(vc: ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
    }
    //添加控制器
    private func addChildViewController(vc: UIViewController,title: String,imageName:String){
        //设置标题
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        let nav = UINavigationController(rootViewController: vc)
        addChild(nav)
        
        
    }
    
    
}

