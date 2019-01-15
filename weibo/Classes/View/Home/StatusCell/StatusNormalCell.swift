//
//  StatusNormalCell.swift
//  weibo
//
//  Created by yangyingwei on 2019/1/14.
//  Copyright © 2019 yangyingwei. All rights reserved.
//

import Foundation
// 原创微博 Cell
class StatusNormalCell: StatusCell {
    /// 微博视图模型
    override var viewModel: StatusViewModel? {
        didSet {
            
            // 修改配图视图大小
            pictureView.snp_updateConstraints { (make) -> Void in
                // 根据配图数量，决定配图视图的顶部间距
                let offset = viewModel?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
                make.top.equalTo(contentLabel.snp_bottom).offset(offset)
            }
        }
    }
    
    override func setupUI() {
        
        super.setupUI()
        
        // 3> 配图视图
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(contentLabel.snp_left)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
    }
    
    
    
}
