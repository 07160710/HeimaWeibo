//
//  UIButton+Extension.swift
//  kkk
//
//  Created by apple on 17/9/13.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
extension UIButton
{
    convenience init(imageName:String,backImageName:String?)
    {
        self.init()
        setImage(UIImage(named:imageName), for: .normal)
        setImage(UIImage(named:imageName+"_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named:backImageName!), for: .normal)
        setBackgroundImage(UIImage(named:backImageName!+"_highlighted"), for: .highlighted)
        sizeToFit()
    }
    convenience init(title:String,color:UIColor,backImageName:String)
    {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setBackgroundImage(UIImage(named:backImageName), for: .normal)
        sizeToFit()
    }
    convenience init(title:String,fontSize:CGFloat,color:UIColor,imageName:String)
    {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setImage(UIImage(named:imageName), for: .normal)
        titleLabel?.font=UIFont.systemFont(ofSize: fontSize)
        sizeToFit()
        
    }
}
