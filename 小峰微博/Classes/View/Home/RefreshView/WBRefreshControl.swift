//
//  WBRefreshControl.swift
//  小峰微博
//
//  Created by apple on 18/5/30.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

let WBRefreshControlOffset:CGFloat = -60

class WBRefreshControl: UIRefreshControl {
    public lazy var refreshView = WBRefreshView.refreshView()
    
    //public var rotateFlag = false
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if frame.origin.y > 0 {
            return
        }
        
        if isRefreshing{
            refreshView.startAnimation()
            return
        }
        
        if frame.origin.y < WBRefreshControlOffset && !refreshView.rotateFlag {
            print("反过来")
            refreshView.rotateFlag = true
        }
        else if frame.origin.y >= WBRefreshControlOffset && refreshView.rotateFlag {
            print("转过去")
            refreshView.rotateFlag = false
        }
    }
    
    
    override init(){
        super.init()
        setupUI()
    }
    
    override func endRefreshing(){
        super.endRefreshing()
        refreshView.stopAnimation()
    }
    
    override func beginRefreshing(){
        super.beginRefreshing()
        refreshView.startAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    
    public func setupUI(){
        tintColor = UIColor.clear
        addSubview(refreshView)
        refreshView.snp.makeConstraints{
            (make) -> Void in
            make.center.equalTo(self.snp.center)
            make.size.equalTo(refreshView.bounds.size)
        }
        
        DispatchQueue.main.async() {() ->Void in
            self.addObserver(self, forKeyPath: "frame", options: [], context: nil)
        }
    }
    
    deinit{
        self.removeObserver(self, forKeyPath: "frame")
    }
    
    
}


class WBRefreshView:UIView{
    
    @IBOutlet weak var tipIconView: UIImageView!
    
    
    @IBOutlet weak var loadingIconView: UIImageView!
    
    @IBOutlet weak var tipView: UIView!
    
    
    
    var rotateFlag = false{
        didSet{
            rotateTipIcon()
        }
    }
    
    public func rotateTipIcon(){
        var angle = CGFloat(M_PI)
        angle += rotateFlag ? -0.0000001 : 0.0000001
        
        UIView.animate(withDuration:0.5){ () -> Void in
            
            self.tipIconView.transform = self.tipIconView.transform.rotated(by: CGFloat(angle))
        }
    }
    
    public func startAnimation(){
        tipView.isHidden = true
        let key = "transform.rotation"
        if loadingIconView.layer.animation(forKey: key) != nil {
            return
        }
        let anim = CABasicAnimation(keyPath:key)
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 0.5
        anim.isRemovedOnCompletion = false
        loadingIconView.layer.add(anim, forKey: key)
    }
    
    public func stopAnimation(){
        tipView.isHidden = false
        loadingIconView.layer.removeAllAnimations()
    }
    
    class func refreshView() -> WBRefreshView{
        let nib = UINib(nibName:"WBRefreshView",bundle:nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as!
        WBRefreshView
    }
}
