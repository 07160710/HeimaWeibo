//
//  StatusCellTopVIew.swift
//  小峰微博
//
//  Created by apple on 18/4/20.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class StatusCellTopVIew: UIView {
    public lazy var iconView:UIImageView=UIImageView(imageName:"avatar_default_big")
    public lazy var nameLabel:UILabel=UILabel(title:"王老五",fontSize:14)
    public lazy var memberIconView:UIImageView=UIImageView(imageName: "common_icon_membership_level1")
    public lazy var vipIconView:UIImageView=UIImageView(imageName: "avatar_vip")
    public lazy var timeLabel:UILabel=UILabel(title: "现在", fontSize: 11, color: UIColor.orange)
    public lazy var sourceLabel:UILabel=UILabel(title: "来源", fontSize: 11)
    var viewModel:StatusViewModel?
        {
        didSet{
            nameLabel.text=viewModel?.status.user?.screen_name
            iconView.sd_setImage(with: viewModel?.userProfileUrl as URL?, placeholderImage:viewModel?.userDefaultIconView)
            memberIconView.image=viewModel?.userMemberImage
            vipIconView.image=viewModel?.userVipImage
            timeLabel.text="刚刚"
            sourceLabel.text="来自黑马博客"
        }
    }
    
    let StatusCellMargin:CGFloat=12
    let StatusCellIconWidth:CGFloat=35
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension StatusCellTopVIew{
    
    public func setupUI()
    {
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(memberIconView)
        addSubview(vipIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        let sepView=UIView()
        sepView.backgroundColor=UIColor.lightGray
        addSubview(sepView)
        
        sepView.snp.makeConstraints{
            (make)->Void in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(StatusCellMargin)
        }
        
        iconView.snp.makeConstraints{
            (make)->Void in
            make.top.equalTo(sepView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(self.snp.left).offset(StatusCellMargin)
            make.width.equalTo(StatusCellIconWidth)
            make.height.equalTo(StatusCellIconWidth)
        }
        
        nameLabel.snp.makeConstraints{
            (make)->Void in
            
            make.top.equalTo(iconView.snp.top)
            make.left.equalTo(iconView.snp.right).offset(StatusCellMargin)
        }
        memberIconView.snp.makeConstraints{
            (make)->Void in
            make.top.equalTo(nameLabel.snp.top)
            make.left.equalTo(nameLabel.snp.right).offset(StatusCellMargin)
        }
        
        vipIconView.snp.makeConstraints{
            (make)->Void in
            make.centerX.equalTo(iconView.snp.right)
            make.centerY.equalTo(iconView.snp.bottom)
        }
        
        timeLabel.snp.makeConstraints{
            (make)->Void in
            make.bottom.equalTo(iconView.snp.bottom)
            make.left.equalTo(iconView.snp.right).offset(StatusCellMargin)
            
        }
        sourceLabel.snp.makeConstraints{
            (make)->Void in
            make.bottom.equalTo(timeLabel.snp.bottom)
            make.left.equalTo(timeLabel.snp.right).offset(StatusCellMargin)
            
        }
    }
}

