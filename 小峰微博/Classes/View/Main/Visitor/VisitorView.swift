//
//  VisitorView.swift
//  小峰微博
//
//  Created by Student on 17/9/20.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    public lazy var iconView:UIImageView=UIImageView(image:UIImage(named:"visitordiscover_feed_image_smallicon"))
    public lazy var homeIconView:UIImageView=UIImageView(image:UIImage(named:"visitordiscover_feed_image_house"))
    public lazy var messageLabel:UILabel={
        let label=UILabel()
        label.text="关注一些人，回这里看看有什么惊喜"
        label.textColor=UIColor.darkGray
        label.font=UIFont.systemFont(ofSize:14)
        label.numberOfLines=0
        label.textAlignment=NSTextAlignment.center
        return label
    }()
    /*public lazy var registerButton:UIButton={
     
     let button=UIButton()
     button.setTitle("注册", for: UIControlState.normal)
     button .setTitleColor(UIColor.orange, for: UIControlState.normal)
     button.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: UIControlState.normal)
     return button
     }()
     public lazy var loginButton:UIButton={
     
     let button=UIButton()
     button.setTitle("登录", for: UIControlState.normal)
     button .setTitleColor(UIColor.orange, for: UIControlState.normal)
     button.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: UIControlState.normal)
     return button
     }()*/
    
    public lazy var registerButton:UIButton=UIButton(title:"注册",color:UIColor.orange,backImageName:"common_button_white_disable")
    public lazy var loginButton:UIButton=UIButton(title:"登陆",color:UIColor.orange,backImageName:"common_button_white_disable")
    public lazy var maskIconView:UIImageView=UIImageView(image:UIImage(named:"visitordiscover_feed_mask_smallicon"))
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setupUI()
    }
    
}
extension VisitorView
{
    public func setupUI()
    {
        addSubview(iconView)
        addSubview(homeIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        addSubview(maskIconView)
        for v in subviews
        {
            v.translatesAutoresizingMaskIntoConstraints=false
        }
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))
        
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 224))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .left, relatedBy: .equal, toItem: messageLabel, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: messageLabel, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[mask]-0-|", options: [], metrics: nil, views: ["mask":maskIconView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mask]-(btnHeight)-[regButton]", options: [], metrics: ["btnHeight":-36], views: ["mask":maskIconView,"regButton":registerButton]))
        
        self.backgroundColor=UIColor(white: 237.0/255.0, alpha: 1.0)
    }
    public func setupInfo(imageName:String?,title:String)
    {
        messageLabel.text=title
        guard let imgName=imageName else{
            startAnim()
            return
        }
        iconView.image=UIImage(named:imgName)
        homeIconView.isHidden=true
        sendSubview(toBack: maskIconView)
    }
    public func startAnim()
    {
        let anim=CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue=2*M_PI
        anim.repeatCount=MAXFLOAT
        anim.duration=20
        anim.isRemovedOnCompletion=false
        iconView.layer.add(anim, forKey: nil)
    }
}
