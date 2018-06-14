//
//  User.swift
//  小峰微博
//
<<<<<<< HEAD
//  Created by apple on 18/4/20.
=======
//  Created by apple on 18/4/8.
>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit
<<<<<<< HEAD

class User: NSObject {
    var id:Int=0// 用户uid
    var screen_name:String?//用户昵称
    var profile_image_url:String?//用户头像地址，50*50
    var verified_type:Int=0//认证类型，0认证用户，2，3，5企业认证，220达人
    var mbrank:Int=0// 会员等级0-6
    init(dict:[String:AnyObject])
    {
=======
class User:NSObject{
    var id:Int = 0
    var screen_name:String?
    var profile_image_url:String?
    var verified_type:Int = 0
    var mbrank:Int = 0
    init(dict:[String:AnyObject]){
>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
<<<<<<< HEAD
    
    override var description: String{
        let keys=["id","screen_name","profile_image_url","verified_type","mbrank"]
        //print(self.id)
=======
    override var description: String{
        let keys=["id","screen_name","profile_image_url","verified_type","mbrank"]
>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
        return dictionaryWithValues(forKeys: keys).description
    }
}
