//
//  UserAccountViewModel.swift
//  小峰微博
//
//  Created by apple on 17/11/15.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

class UserAccountViewModel{
    
    var account:UserAccount?
    public var accountPath:String
    {
        let path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        return (path as NSString).strings(byAppendingPaths: ["account.plist"]).last!
        
    }
    var avatarUrl:NSURL{
        return NSURL(string:account?.avatar_large ?? "")!
    }
    private init()
    {
        account=NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
        if isExpired
        {
            print("已经过期")
            account=nil
        }
    }
    
    public var isExpired:Bool
    {
        if account?.expiresDate?.compare(NSDate() as Date) == ComparisonResult.orderedDescending
        {
            return false
        }
        return true
    }
    var userLogin:Bool
    {
        return account?.access_token != nil && !isExpired
    }
    static let sharedUserAccount=UserAccountViewModel()
}
extension UserAccountViewModel
{
    //oauthviewcontroller中的2个函数移植过来
    func loadAccessToken(code:String,finished:@escaping (_ isSuccessed:Bool)->())
    {
        NetworkTools.sharedTools.loadAccessToken(code: code){ (result:Any?, error:Error?) in
            if error != nil//新改
            {
                print("错了")
                finished(false)
                return
            }
            
            self.account=UserAccount(dict: result as! [String:Any])
            //print(account.description)
            self.loadUserInfo(account: self.account!,finished:finished)
        }
    }
    
    public func loadUserInfo(account:UserAccount,finished:@escaping (_ isSuccessed:Bool)->())
    {
        NetworkTools.sharedTools.loadUserInfo(uid: account.uid!)//, accessToken:account.access_token!)
        {(result,error)->() in
            if error != nil
            {
                print("加载用户出错了")
                finished(false)
                
                return
            }
            guard let dict=result as? [String:AnyObject] else
            {
                print("格式错误")
                finished(false)
                
                return
            }
            
            //print(dict["screen_name"] as! String)
            //print(dict["avatar_large"] as! String)
            account.screen_name=dict["screen_name"] as! String
            account.avatar_large=dict["avatar_large"] as! String
            //print(account)
            NSKeyedArchiver.archiveRootObject(account, toFile: self.accountPath)
            print(self.accountPath)
            finished(true)
        }
    }
    var accessToken:String?
    {
        if !isExpired
        {
            return account?.access_token
        }
        return nil
    }
}
