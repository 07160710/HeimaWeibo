//
//  StatusNormalCell.swift
//  小峰微博
//
//  Created by apple on 18/5/25.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class StatusNormalCell: StatusCell {
    override var viewModel: StatusViewModel?{
        didSet{
            pictureView.snp.updateConstraints{
                (make) -> Void in
                let offset = viewModel?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
                make.top.equalTo(contentLabel.snp.bottom).offset(offset)
            }
        }
    }
    override func setupUI() {
        super.setupUI()
        pictureView.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentLabel.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
    }

}
