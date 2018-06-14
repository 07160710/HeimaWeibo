//
//  UIImageView+Extension.swift
//  小峰微博
//
//  Created by apple on 17/11/23.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit
extension UIImageView
{
    convenience init(imageName:String)
    {
        self.init(image:UIImage(named:imageName))
    }
}
