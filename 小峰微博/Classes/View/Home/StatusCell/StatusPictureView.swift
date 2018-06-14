//
//  StatusPictureView.swift
//  小峰微博
//
//  Created by apple on 18/5/4.
//  Copyright © 2018年 Student. All rights reserved.
//
import UIKit

class StatusPictureView: UICollectionView {
    public let StatusPictureViewItemMargin:CGFloat = 8
    
    init()
    {
        let layout=UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing=StatusPictureViewItemMargin
        layout.minimumLineSpacing=StatusPictureViewItemMargin
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        backgroundColor=UIColor(white: 0.8, alpha: 1.0)
        
        // 设置数据源 - 自己当自己的数据源
        // 应用场景：自定义视图的小框架
        dataSource = self
        
        //注册可重用的cell
        register(StatusPictureViewCell.self, forCellWithReuseIdentifier: StatusPictureCellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel:StatusViewModel?
        {
        didSet
        {
            sizeToFit()//让配图有个合适的尺寸
            reloadData()
        }
        
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return cacViewSize()//CGSize(width: 150, height: 120)
    }
}
extension StatusPictureView:UICollectionViewDataSource
{
    public func cacViewSize()->CGSize
    {
        let rowCount:CGFloat=3
        let maxWidth=UIScreen.main.bounds.width-2*StatusCellMargin
        let itemWidth=(maxWidth-2*StatusPictureViewItemMargin)/rowCount
        
        let layout=collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize=CGSize(width: itemWidth, height: itemWidth)
        
        let count=viewModel?.thumbnailUrls?.count ?? 0
        ///没有图片
        if count==0
        {
            return CGSize.zero
        }
        ///1张图片
        if count==1
        {
            var size=CGSize(width: 150, height: 120)
            //layout.itemSize=size
            //return size
            if let key = viewModel?.thumbnailUrls?.first?.absoluteString{
                let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: key)
                print(key)
                size = image?.size ?? CGSize.zero
            }
            size.width = size.width < 40 ? 40 : size.width
            if size.width > 300{
                let w:CGFloat = 300
                let h = size.height
                size = CGSize(width:w,height:h)
            }
            layout.itemSize = size
            return size
        }
        ///4张图片2*2
        if count==4
        {
            let w=2*itemWidth+StatusPictureViewItemMargin
            return CGSize(width: w, height: w)
        }
        ///其它图片按照九宫格来显示
        ///计算出行数
        let row=CGFloat((count-1)/Int(rowCount)+1)
        let h=row*itemWidth+(row-1)*StatusPictureViewItemMargin+1
        let w=rowCount*itemWidth+(rowCount-1)*StatusPictureViewItemMargin+1
        return CGSize(width: w, height: h)
        
    }
    //返回thumbnailUrls个数，就是图片的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.thumbnailUrls?.count ?? 0
    }
    //设置格子的内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: StatusPictureCellId, for: indexPath) as! StatusPictureViewCell
        //cell.backgroundColor=UIColor.red
        cell.imageURL = viewModel!.thumbnailUrls![indexPath.item]
        return cell
    }
}
let StatusPictureCellId="StatusPictureCellId"
import SDWebImage
class StatusPictureViewCell: UICollectionViewCell {
    public lazy var gifIconView:UIImageView=UIImageView(imageName:"timeline_image_gif")
    public lazy var iconView:UIImageView = {//UIImageView()
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill// 完全填充模式
        iv.clipsToBounds=true//局限于试图边界
        return iv
    }()
    var imageURL:NSURL?{
        
        didSet
        {
            iconView.sd_setImage(with:imageURL as URL?, placeholderImage: nil, options: [SDWebImageOptions.retryFailed,SDWebImageOptions.refreshCached])//重试，刷新缓存
            
            let ext = ((imageURL?.absoluteString ?? "") as NSString).pathExtension.lowercased()
            gifIconView.isHidden = (ext != "gif")
        }
    }
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupUI()
    {
        contentView.addSubview(iconView)
        iconView.addSubview(gifIconView)
        iconView.snp.makeConstraints{
            (make)->Void in
            make.edges.equalTo(contentView.snp.edges)
        }
        gifIconView.snp.makeConstraints{
            (make)->Void in
            make.right.equalTo(iconView.snp.right)
            make.bottom.equalTo(iconView.snp.bottom)
            
        }
    }
}



