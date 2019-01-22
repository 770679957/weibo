//
//  ComposeViewController.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/20.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit
import SVProgressHUD
import SnapKit

// MARK: - 撰写控制器
class ComposeViewController: UIViewController {
    
   //关闭
    @objc private func close(){
        //关闭键盘
        textView.resignFirstResponder()
        
        dismiss(animated: true, completion: nil)
        
        
    }
    //发布微博
    @objc private func sendStatus() {
        //获取文本内容
        let text = textView.text        //发布微博
        NetworkTools.sharedTools.sendStatus(status: text!) { (result, error) -> () in

            if error != nil {
                print("出错了")
                SVProgressHUD.showInfo(withStatus: "您的网络不给力")
                return
            }

            print(result)
            // 关闭控制器
            self.close()
        }
        
    }
    
    /// 选择表情
    @objc private func selectEmoticon() {
        
        //print("选择表情")
    }
    
    // MARK: - 键盘处理
    /// 键盘变化处理
    @objc private func keyboardChanged(n: NSNotification) {
         // 1. 获取目标的rect - 字典中的`结构体`是 NSValue
        let rect = (n.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //获取目标的动画时长
        let duration = (n.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let offset = -UIScreen.main.bounds.height + rect.origin.y
        //更新约束
        toolbar.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(offset)
        }
        
        //动画
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加键盘通知
        // 添加键盘通知
       // NotificationCenter.defaultCenter.addObserver(self,selector:#selector(ComposeViewController.keyboardChanged), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ComposeViewController.keyboardChanged), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    //视图生命周期
    override func loadView() {
        view = UIView()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        // 激活键盘 - 如果已经存在照片控制器视图，不再激活键盘
        textView.becomeFirstResponder()
    }
    
    // MARK: - 懒加载控件
    /// 工具条
    private lazy var toolbar = UIToolbar()
    
    //文本视图
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.textColor = UIColor.darkGray
        //设置文本视图的代理
        tv.delegate = self
        
        //始终允许垂直滚动
        tv.alwaysBounceVertical = true
        // 拖拽关闭键盘
        tv.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        
        return tv
    }()
    
    //占位标签
    private lazy var placeHolderLabel: UILabel = UILabel(title: " ",fontSize: 18,color: UIColor.lightGray)
    
}

// MARK: - UITextViewDelegate
extension ComposeViewController: UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
        placeHolderLabel.isHidden = textView.hasText
    }
}


// MARK: - 设置界面
private extension ComposeViewController {
    func setupUI() {
        
        //设置背景颜色
        view.backgroundColor = UIColor.white
        //设置控件
        prepareNavigationBar()
        prepareToolbar()
        prepareTextView()
    }
    //设置导航栏
    private func prepareNavigationBar() {
        //左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: "close")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: "sendStatus")
        
        //标题视图
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
        navigationItem.titleView = titleView
        //禁用发布微博按钮
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        //添加子视图
        let titleLabel = UILabel(title: "发微博", fontSize: 15)
        let nameLabel = UILabel(title: UserAccountViewModel.sharedUserAccount.account?.screen_name ?? "", fontSize: 13, color: UIColor.lightGray)
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(nameLabel)
        
        
        //给自控件添加约束
        titleLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(titleView.snp_centerX)
            make.top.equalTo(titleView.snp_top)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(titleView.snp_centerX)
            make.bottom.equalTo(titleView.snp_bottom)
        }
        
    }
    
    //准备文本视图
    private func prepareTextView() {
        view.addSubview(textView)
        
        textView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.bottom.equalTo(toolbar.snp_top)
            
        }
        
        textView.text = "分享新鲜事......."
        
        
    }
    
    //准备工具条
    private func prepareToolbar() {
        //添加控件
        view.addSubview(toolbar)
        //设置背景颜色
        toolbar.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        //自动布局
        toolbar.snp_makeConstraints { (make) in
            make.bottom.equalTo(view.snp_bottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.height.equalTo(44)
        }
        
        //添加按钮
        //定义数组itemSettings,用于表示要添加的子控件信息
        let itemSettings = [["imageName": "compose_toolbar_picture", "actionName": "selectPicture"],
                            ["imageName": "compose_mentionbutton_background"],
                            ["imageName": "compose_trendbutton_background"],
                            ["imageName": "compose_emoticonbutton_background", "actionName": "selectEmoticon"],
                            ["imageName": "compose_addbutton_background"]]
        //定义数组itemsm,用于表示所有的子控件
        var items = [UIBarButtonItem]()
        //遍历数组
        for dict in itemSettings {
            //根据子控件的信息创建UIButton对象
            items.append(UIBarButtonItem(imageName: dict["imageName"]!, target: self, actionName: dict["actionName"]))
//            let button = UIButton(imageName: dict["imageName"]!, backImageName: nil)
//            //判断actionName是否存在，如果存在，则为子控件添加事件处理方法
//            if let actionName = dict["actionName"] {
//                button.addTarget(self, action: Selector(actionName), for: .touchUpInside)
//            }
//
//            //将使用UIbutton创建UIBarButtonItem
//            let item = UIBarButtonItem(customView: button)
//            //添加子控件
//            items.append(item)
            //添加可变长度控件，用于填充子控件之间的空隙
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
            
        }
        //去掉最后一个多余的可变长度控件
        items.removeLast()
        //将数组items赋值给工具条的子控件集合
        toolbar.items = items
        
        
        //添加占位标签
        textView.addSubview(placeHolderLabel)
        placeHolderLabel.snp_makeConstraints { (make) in
            make.top.equalTo(textView.snp_top).offset(8)
            make.left.equalTo(textView.snp_left).offset(5)
        }
        
        
        
        
        
    }
    
    
}
