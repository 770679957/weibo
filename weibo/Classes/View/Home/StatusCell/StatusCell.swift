//
//  StatusCell.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/12.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import UIKit

// 微博 Cell 中控件的间距数值
let StatusCellMargin: CGFloat = 12
/// 微博头像的宽度
let StatusCellIconWidth: CGFloat = 35


class StatusCell: UITableViewCell {
 
    //顶部视图
    lazy var topView: StatusCellTopView = StatusCellTopView()
    //正文标签
    lazy var contentLabel:UILabel = UILabel(title: "微博正文", fontSize: 15, color: UIColor.darkGray,screenInset:StatusCellMargin)
    // 配图视图
    lazy var pictureView: StatusPictureView = StatusPictureView()
    //底部视图
    lazy var bottomView:StatusCellBottomView = StatusCellBottomView()
    
    // MARK: - 构造函数
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //微博视图模型
    var viewModel:StatusViewModel? {
        
        didSet {
            
            topView.viewModel = viewModel
            
            contentLabel.text = viewModel?.status.text
            
            // 测试动态修改行高
//            pictureView.snp.makeConstraints{
//                (make)->Void in
//
//                make.height.equalTo(Int(arc4random()) % 4 * 90)
//            }
            
            //设置配图视图- 设置视图模型之后，配图视图才有能力计算大小
            pictureView.viewModel=viewModel
            pictureView.snp.updateConstraints{ (make) -> Void in
                make.height.equalTo(pictureView.bounds.height)
 
                print(pictureView.bounds.width)
                make.width.equalTo(pictureView.bounds.width)
            }
            
        }
    }
    
    /// 根据指定的视图模型计算行高
    /// - parameter vm: 视图模型
    /// - returns: 返回视图模型对应的行高
    func rowHeight(vm: StatusViewModel) -> CGFloat {
        // 1. 记录视图模型 -> 会调用上面的 didSet 设置内容以及更新`约束`
        viewModel = vm
        
        // 2. 强制更新所有约束 -> 所有控件的frame都会被计算正确
        contentView.layoutIfNeeded()
        
        // 3. 返回底部视图的最大高度
        return bottomView.frame.maxY
    }
}


extension StatusCell {
    //p186
   @objc func setupUI() {
        //添加控件
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(pictureView)
        contentView.addSubview(bottomView)
        //顶部视图
        topView.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo( 2 * StatusCellMargin + StatusCellIconWidth)
        }
        
        //内容标签
        contentLabel.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(topView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left).offset(StatusCellMargin)
            
        }
        
        //配图视图
//         pictureView.snp.makeConstraints{ (make)->Void in
//             make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
//             make.left.equalTo(contentView.snp.left)
//             make.width.equalTo(300)
//             make.height.equalTo(90)
//
//         }
 
        //底部试图
        bottomView.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(pictureView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(44)
        }
        
    }
}

