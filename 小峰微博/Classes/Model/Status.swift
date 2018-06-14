//
//  Status.swift
//  小峰微博
//
//  Created by apple on 17/11/30.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

class Status: NSObject {
    
    var id:Int=0
    var text:String?
    var create_at:String?
    var source:String?
<<<<<<< HEAD
    var user:User?//用户模型
    var pic_urls:[[String:String]]?
    var retweeted_status:Status?
    
    init(dict:[String:AnyObject]) {
=======
    var user:User?
    init(dict:[String:AnyObject]){
>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
        super.init()
        self.setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
<<<<<<< HEAD
        let keys=["id","text","create_at","source","user","pic_urls","retweeted_status"]
        return dictionaryWithValues(forKeys: keys).description
    }
    override func setValue(_ value: Any?, forKey key: String) {
        //判断key是否是user
=======
        let keys=["id","text","created_at","source","user"]
        return dictionaryWithValues(forKeys: keys).description
    }
    override func setValue(_ value: Any?, forKey key: String) {
>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
        if key == "user"
        {
            if let dict = value as? [String:AnyObject]
            {
                user=User(dict:dict)
            }
            return
        }
<<<<<<< HEAD
        if key == "retweeted_status"{
            if let dict = value as? [String:AnyObject]{
                retweeted_status = Status(dict:dict)
            }
            return
        }
        super.setValue(value, forKey: key)
    }
=======
        super.setValue(value, forKey: key)
    }

>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
}

