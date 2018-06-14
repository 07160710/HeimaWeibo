//
//  OAuthViewController.swift
//  小峰微博
//
//  Created by apple on 17/10/19.
//  Copyright © 2017年 Student. All rights reserved.
//

import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    public let appKey="4032459860"
    public let appSecret="2dc1656a68af5c656e55c5f1fb9fbe59"
    public let redirectUrl="http://www.baidu.com"
    var OAuthURL:URL
    {
        let urlString="https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUrl)&response_type=code"
        return URL(string:urlString)!
    }
    static let sharedTools:NetworkTools={
        let tools=NetworkTools(baseURL: nil)
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return tools
    }()
    //typealias  HMRequestCallBack = (Any?,URLSessionDataTask?)->()
    typealias  HMRequestCallBack = (Any?,Error?)->()//新修改
}
extension NetworkTools
{
    func request(method:HMRequestMethod,URLString:String,parameters:[String:AnyObject]?,finished:@escaping HMRequestCallBack)
    {
        let success={(task:URLSessionDataTask?,result:Any?)->() in finished(result,nil)}//新修改
        let failure={(task:URLSessionDataTask?,error:Error?)->() in finished(nil,error)}//新修改
        
        if method==HMRequestMethod.GET
        {
            get(URLString, parameters: parameters, progress: nil, success: success,failure:failure)
        }
        if method==HMRequestMethod.POST
        {
            //post(URLString, parameters: parameters, progress: nil, success: {(result,error) in finished(result,nil)},failure:{(result,error) in finished(result,nil)})
            post(URLString, parameters: parameters, progress: nil, success: success,failure:failure)
        }
    }
    func loadAccessToken(code:String,finished:@escaping HMRequestCallBack)
    {
        let urlString="https://api.weibo.com/oauth2/access_token"
        let params:[String:AnyObject]?=["client_id":appKey as AnyObject,"client_secret":appSecret as AnyObject,"grant_type":"authorization_code" as AnyObject,"code":code as AnyObject,"redirect_uri":redirectUrl as AnyObject]
        request(method: .POST, URLString: urlString, parameters: params, finished: finished)
    }
    
    func loadUserInfo(uid:String,/*accessToken:String,*/finished:@escaping HMRequestCallBack){
        guard var params=tokenDict else {
            finished(nil,NSError(domain:"cn.itcast.error",code:-1001,userInfo:["message":"token is nil"]))
            return
        }
        
        let urlString="https://api.weibo.com/2/users/show.json"
        params["uid"]=uid as AnyObject?
        request(method: .GET, URLString: urlString, parameters: params, finished: finished)
    }
    public var tokenDict:[String:AnyObject]?{
        if let token=UserAccountViewModel.sharedUserAccount.account?.access_token
        {
            return ["access_token":token as AnyObject]
        }
        return nil
    }
    
}
enum HMRequestMethod:String
{
    case GET="GET"
    case POST="POST"
}
extension NetworkTools
{
    func loadStatus(since_id:Int,max_id:Int,finished:@escaping HMRequestCallBack)
    {
        var params = [String:AnyObject]()
        
        guard let p=tokenDict else
        {
            finished(nil,NSError(domain:"cn.itcast.error",code:-1001,userInfo:["message":"token is nil"]))
            return
        }
        
        params["access_token"] = p["access_token"]
        
        if since_id > 0 {
            params["since_id"] = since_id as AnyObject?
        }else if max_id > 0 {
            params["max_id"] = max_id - 1 as AnyObject?
        }
        
        
        
        
        let urlString="https://api.weibo.com/2/statuses/home_timeline.json"
        request(method: .GET, URLString: urlString, parameters: params, finished: finished)
    }
}

    
