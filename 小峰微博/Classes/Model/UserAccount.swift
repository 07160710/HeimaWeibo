//
//  UserAccount.swift
//  小峰微博
//
//  Created by apple on 17/11/2.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

class UserAccount:NSObject,NSCoding {
    var access_token:String?
    var uid:String?
    var expiresDate:NSDate?//新改
    var expires_in:TimeInterval=0
        {
        didSet
        {
            expiresDate=NSDate(timeIntervalSinceNow:expires_in)//新改
            
        }
    }
    var isRealName:Bool=false
    var remind_in:TimeInterval=0
    var screen_name:String=""
    var avatar_large:String=""
    init(dict:[String:Any]) {
        //print("init")
        super.init()
        self.setValuesForKeys(dict)
        //print(self.uid! as String)
        
        
    }
    override func setValue(_ value: Any?, forKey key: String) {
        
        super.setValue(value, forKey: key)
    }
    
    override var description: String{
        let keys=["access_token","expires_in","expiresDate","uid","screen_name","avatar_large"]
        //print(self.uid)
        return dictionaryWithValues(forKeys: keys).description
    }
    
    
    func saveUserAccount()
    {
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        path=(path as NSString).strings(byAppendingPaths:["account.plist"]).last!
        print("path:"+path)
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
        
    }
    required init(coder aDecoder: NSCoder)
    {
        //print("aDecoder.decodeObject"+"aaaaaaaaaaaaaaaaaaaa")
        access_token=aDecoder.decodeObject(forKey: "access_token") as? String
        expiresDate=aDecoder.decodeObject(forKey:"expiresDate") as? NSDate
        uid=aDecoder.decodeObject(forKey: "uid") as? String
        screen_name=aDecoder.decodeObject(forKey: "screen_name") as! String
        avatar_large=aDecoder.decodeObject(forKey: "avatar_large") as! String
    }
    func encode(with aCoder: NSCoder)
    {
        //print("aCoder.encode"+"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb")
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expiresDate, forKey: "expiresDate")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
}
