//
//  OAuthViewController.swift
//  小峰微博
//
//  Created by apple on 17/10/19.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {
    
    public lazy var webView=UIWebView()
    @objc
    public func close()
    {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        
        view=webView
        webView.delegate=self
        title="登陆新浪微博"
        navigationItem.leftBarButtonItem=UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(OAuthViewController.close))
        self.webView.loadRequest(URLRequest(url:NetworkTools.sharedTools.OAuthURL))
        
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "自动填充", style: .plain, target: self, action: #selector(OAuthViewController.autoFill))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc
    public func autoFill()
    {
        let js="document.getElementById('userId').value='1195745286@qq.com';"+"document.getElementById('passwd').value='619375'"
        webView.stringByEvaluatingJavaScript(from: js)
    }
    
}
extension OAuthViewController:UIWebViewDelegate
{
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        
        guard let url=request.url,url.host == "www.baidu.com" else
        {
            return true
        }
        guard let query=url.query , query.hasPrefix("code=") else
        {
            print("取消授权")
            return false
        }
        let code=query.substring(from: "code=".endIndex)
        print("授权码是"+code)
        UserAccountViewModel.sharedUserAccount.loadAccessToken(code: code){
            (isSuccessed)->() in
            if !isSuccessed
            {
                return
            }
            print("成功了")
            self.dismiss(animated: false){
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification), object: "welcome")
            }
        }
        return false
    }
}
