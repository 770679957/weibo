//
//  StatusRetweetedCell.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/14.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import Foundation
class StatusRetweetedCell: StatusCell {
    
    /// 微博视图模型
    override var viewModel: StatusViewModel? {
        didSet {
            // 转发微博的文字
//            let text = viewModel?.retweetedText ?? ""
//            retweetedLabel.attributedText = EmoticonManager.sharedManager.emoticonText(text, font: retweetedLabel.font)
            retweetedLabel.text = viewModel?.retweetedText
            
            pictureView.snp_updateConstraints { (make) -> Void in
                
                // 根据配图数量，决定配图视图的顶部间距
                let offset = viewModel?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
                make.top.equalTo(retweetedLabel.snp_bottom).offset(offset)
            }
        }
    }
    //背景图片
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        return button
    }()
    
    //转发微博标签
    lazy var retweetedLabel: UILabel = UILabel (title: "转发微博", fontSize: 14, color: UIColor.darkGray, screenInset: StatusCellMargin)
    
    override func setupUI() {
        super.setupUI()
        contentView.insertSubview(backButton,belowSubview:pictureView)
        contentView.insertSubview(retweetedLabel, aboveSubview: backButton)
        
        backButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(bottomView.snp.top)
        }
        retweetedLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(backButton.snp.top).offset(StatusCellMargin)
            make.left.equalTo(backButton.snp.left).offset(StatusCellMargin)
        }
        //配图视图
        pictureView.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(retweetedLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(retweetedLabel.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
            
        }
    }
    
 
    
}


//设置界面
extension StatusRetweetedCell {
    //设置界面

    
}
