//
//  StatusViewModel.swift
//  小峰微博
//
<<<<<<< HEAD
//  Created by apple on 18/4/20.
//  Copyright © 2018年 Student. All rights reserved.
//

import Foundation
import UIKit
class StatusViewModel
{
    var thumbnailUrls:[NSURL]?
    var status:Status//微博模型
    lazy var rowHeight:CGFloat = {
        //print("计算缓存行高\(self.status.text)")
        //let cell = StatusCell(style: .default, reuseIdentifier: StatusCellNormalId)
        var cell:StatusCell
        if self.status.retweeted_status != nil{
            cell = StatusRetweetedCell(style:.default,reuseIdentifier:StatusCellRetweetedId)
        }else{
            cell = StatusNormalCell(style:.default,reuseIdentifier:StatusCellNormalId)
        }
        //let cell = StatusRetweetedCell(style:.default,reuseIdentifier:StatusCellRetweetedId)
        //return cell.rowHeight(vm: self)
        return cell.rowHeight(vm: self)
    }()
    init(status:Status)
    {
        self.status=status
        if let urls = status.retweeted_status?.pic_urls ?? status.pic_urls{
            thumbnailUrls = [NSURL]()
            for dict in urls{
                let url = NSURL(string:dict["thumbnail_pic"]!)
                thumbnailUrls?.append(url!)
            }
        }
        
    }
    var userProfileUrl:NSURL{
        return NSURL(string: status.user?.profile_image_url ?? "")!
    }
    var userDefaultIconView:UIImage{
        
        return UIImage(named: "avatar_default_big")!
    }
    var userMemberImage:UIImage?{
        
        if (status.user?.mbrank)! > 0 && (status.user?.mbrank)! < 7
        {
            return UIImage(named: "common_icon_membership_level\(status.user!.mbrank)")
        }
        return nil
    }
    var retweetedText:String?{
        guard let s = status.retweeted_status else{
            return nil
        }
        return "@" + (s.user?.screen_name ?? "") + ":" + (s.text ?? "")!
    }
    var cellId:String{
        return status.retweeted_status != nil ? StatusCellRetweetedId : StatusCellNormalId
    }
    var userVipImage:UIImage?{
        
        switch(status.user?.verified_type ?? -1)
        {
        case 0:return UIImage(named:"avatar_vip")
        case 2,3,5:return UIImage(named:"avatar_enterprise_vip")
        case 220: return UIImage(named:"avatar_grassroot")
        default:return nil
        }
    }
    
}
public protocol CustomStringConvertible{
    var description:String { get }
}
extension StatusViewModel:CustomStringConvertible
{
    public var description:String{
        return status.description
    }
}

=======
//  Created by apple on 18/4/8.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit
class StatusViewModel{
    var status:Status
    init(status:Status){
        self.status = status
    }
}
>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
