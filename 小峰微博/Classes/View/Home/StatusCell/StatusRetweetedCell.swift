//
//  StatusRetweetedCell.swift
//  小峰微博
//
//  Created by apple on 18/5/23.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class StatusRetweetedCell: StatusCell {
    public lazy var backButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(white:0.5,alpha:1.0)
        return button
    }()
    public lazy var retweetedLabel:UILabel = UILabel(
        title:"转发微博转发微博转发微博转发微博转发微博转发微博转发微博转发微博",
        fontSize:14,
        color:UIColor.darkGray,
        screenInset:StatusCellMargin)
    override var viewModel: StatusViewModel?{
        didSet{
            retweetedLabel.text = viewModel?.retweetedText
            pictureView.snp.updateConstraints{(make) -> Void in
                let offset = viewModel?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
                make.top.equalTo(retweetedLabel.snp.bottom).offset(offset)
            }
            
        }
    }
    override func setupUI() {
        super.setupUI()
        contentView.insertSubview(backButton,belowSubview:pictureView)
        contentView.insertSubview(retweetedLabel, aboveSubview: backButton)
        
        backButton.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(bottomView.snp.top)
        }
        retweetedLabel.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(backButton.snp.top).offset(StatusCellMargin)
            make.left.equalTo(backButton.snp.left).offset(StatusCellMargin)
        }
        //配图视图
        pictureView.snp.makeConstraints{
            (make)->Void in
            make.top.equalTo(retweetedLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(retweetedLabel.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
            
        }
    }

}
