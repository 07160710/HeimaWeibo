//
//  NewFeatureViewController.swift
//  小峰微博
//
//  Created by apple on 17/11/16.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

class NewFeatureViewController: UICollectionViewController {
    public let WBNewFeatureViewCellId="WBNewFeatureViewCellId"
    public let WBNewFeatureImageCount=4
    
    init()
    {
        let layout=UICollectionViewFlowLayout()
        
        layout.itemSize=UIScreen.main.bounds.size  //设置每个单元格的尺寸
        layout.minimumInteritemSpacing=0  //设置单元格的间距
        layout.minimumLineSpacing=0    //设置行间距
        layout.scrollDirection = .horizontal    //设置滚动方向时横向
        
        super.init(collectionViewLayout:layout)
        
        collectionView?.isPagingEnabled=true    //开启分页
        collectionView?.bounces=false     //去掉弹簧效果
        collectionView?.showsHorizontalScrollIndicator=false    //去掉水平方向滚动条
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(NewFeatureCell.self, forCellWithReuseIdentifier: WBNewFeatureViewCellId)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1   //返回该集合视图所拥有的组的数量
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return WBNewFeatureImageCount  //返回单元格数量
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath/*单元格在集合视图中的位置*/) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WBNewFeatureViewCellId, for: indexPath) as! NewFeatureCell
        
        
        // Configure the cell
        //cell.backgroundColor=indexPath.item % 2 == 0 ? UIColor.red:UIColor.green
        cell.imageIndex=indexPath.item
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let page=Int(scrollView.contentOffset.x/scrollView.bounds.width)
        
        if page != WBNewFeatureImageCount-1
        {
            return
        }
        
        let cell=collectionView?.cellForItem(at: IndexPath(item: page, section: 0)) as! NewFeatureCell
        cell.showButtonAnim()
    }
    
}
class NewFeatureCell: UICollectionViewCell {
    public lazy var iconView:UIImageView=UIImageView()
    public lazy var startButton:UIButton=UIButton(title:"开始体验",color:UIColor.white,backImageName:"new_feature_finish_button")
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func setupUI()
    {
        addSubview(iconView)
        addSubview(startButton)
        startButton.snp.makeConstraints{
            (make)->Void
            in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).multipliedBy(0.7)
        }
        startButton.addTarget(self, action: #selector(NewFeatureCell.clickStarButton), for: .touchUpInside)
        iconView.frame=bounds//指定位置
        startButton.isHidden=true
        
    }
    public var imageIndex:Int=0
        {
        didSet
        {
            iconView.image=UIImage(named: "new_feature_\(imageIndex+1)")
        }
    }
    public func showButtonAnim()
    {
        
        startButton.isHidden=false
        startButton.transform=CGAffineTransform(scaleX: 0,y: 0)//比例大小不变
        startButton.isUserInteractionEnabled=false
        UIView.animate(withDuration: 1.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: [], animations: {()->Void in self.startButton.transform=CGAffineTransform.identity})
        {(_)->Void in self.startButton.isUserInteractionEnabled=true}
    }
    @objc
    public func clickStarButton()
    {
        //print("开始体验")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification), object: nil)
    }
    
}
