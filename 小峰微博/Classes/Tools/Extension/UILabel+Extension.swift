//
//  UILabel+Extension.swift
//  小峰微博
//
//  Created by apple on 17/11/23.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit
extension UILabel
{
    convenience init(title:String,fontSize:CGFloat=14,color:UIColor=UIColor.darkGray)
    {
        self.init()
        text=title
        textColor=color
        font=UIFont.systemFont(ofSize:fontSize)
        numberOfLines=0
        textAlignment=NSTextAlignment.center
    }
    convenience init(title:String,fontSize:CGFloat=14,color:UIColor=UIColor.darkGray,screenInset:CGFloat=0)
    {
        self.init()
        text=title
        textColor=color
        font=UIFont.systemFont(ofSize: fontSize)
        numberOfLines=0//设置换行除讲linesNumbers属性为0外还要设置preferredMaxLayoutWIdth为最大宽度
        if screenInset == 0
        {
            textAlignment = .center
            
        }
        else
        {
            preferredMaxLayoutWidth=UIScreen.main.bounds.width-2*screenInset
            textAlignment = .left
        }
    }
}
