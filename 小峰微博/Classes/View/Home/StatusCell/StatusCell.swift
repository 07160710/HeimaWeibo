//
//  StatusCell.swift
//  小峰微博
//
//  Created by apple on 18/4/20.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit
let StatusCellMargin:CGFloat=12
class StatusCell: UITableViewCell {
    public let StatusCellIconWidth:CGFloat=35
    
    public lazy var topView:StatusCellTopVIew=StatusCellTopVIew()
    public lazy var contentLabel:UILabel=UILabel(title:"微博正文",fontSize: 15,color:UIColor.darkGray,screenInset:12)//StatusCellMargin)
    public lazy var bottomView:StatusCellBottomView=StatusCellBottomView()
    
    public lazy var pictureView:StatusPictureView=StatusPictureView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var viewModel:StatusViewModel?
        {
        didSet{
            topView.viewModel=viewModel
            contentLabel.text=viewModel?.status.text
            
            pictureView.snp.makeConstraints{
                (make)->Void in
                
                make.height.equalTo(Int(arc4random()) % 4 * 90)
                
            }
            
            pictureView.viewModel=viewModel
            pictureView.snp.updateConstraints{
                (make) -> Void in
                make.height.equalTo(pictureView.bounds.height)
                make.width.equalTo(pictureView.bounds.width)
            }
        }
    }
    
}
extension StatusCell{
    
    
    
    public func setupUI()
    {
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(bottomView)
        contentView.addSubview(pictureView)
        //顶部视图
        topView.snp.makeConstraints{
            (make)->Void in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(2*StatusCellMargin+StatusCellIconWidth)
        }
        
        //内容标签
        contentLabel.snp.makeConstraints{
            (make)->Void in
            make.top.equalTo(topView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left).offset(StatusCellMargin)
            
        }
        //配图视图
        /*
        pictureView.snp.makeConstraints{
            (make)->Void in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
            
        }
         */
        //底部试图
        bottomView.snp.makeConstraints{
            (make)->Void in
            make.top.equalTo(pictureView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(44)
        }
    }
    public func rowHeight(vm:StatusViewModel)->CGFloat
    {
        viewModel=vm
        contentView.layoutIfNeeded()
        return bottomView.frame.maxY
    }
}

