//
//  WelcomeViewController.swift
//  小峰微博
//
//  Created by apple on 17/11/23.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
    private lazy var backImageView:UIImageView=UIImageView(image:UIImage(named: "ad_backround"))
    
    public lazy var iconView:UIImageView={
        let iv=UIImageView(imageName:"avatar_default_big")
        iv.layer.cornerRadius=45
        iv.layer.masksToBounds=true
        return iv
    }()
    
    public lazy var welcomeLabel:UILabel=UILabel(title:"欢迎归来",fontSize:18.0)
    
    override func loadView() {
        view=backImageView
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        iconView.sd_setImage(with: UserAccountViewModel.sharedUserAccount.avatarUrl as URL, placeholderImage: UIImage(named:"avatar_default_big"))//, options: nil, completed: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
<<<<<<< HEAD
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        iconView.snp.updateConstraints{
            (make)            in
            
            make.bottom.equalTo(view.snp.bottom).offset(-view.bounds.height+200)
        }
        welcomeLabel.alpha=0
        
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: {
            self.view.layoutIfNeeded()
        }){(_) in
            UIView.animate(withDuration: 0.8, animations: {
                self.welcomeLabel.alpha=1
            }, completion: {(_) in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification), object: nil)
            })
        }
        
        
=======
    public lazy var backImageView:UIImageView = UIImageView(imageName:"ad_background")
    public lazy var iconView:UIImageView = {
        let iv = UIImageView(imageName:"avatar_default_big")
        iv.layer.cornerRadius = 45
        iv.layer.masksToBounds = true
        return iv
    }()
    public lazy var welcomeLabel:UILabel = UILabel(title:"欢迎回来！！！",fontSize:18)
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
    }
    
}
extension WelcomeViewController{
    
    public func setupUI()
    {
        view.addSubview(iconView)
        iconView.snp.makeConstraints{
            (make)            in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-200)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints{
            (make)
            in
            make.centerX.equalTo(iconView.snp.centerX)
            make.top.equalTo(iconView.snp.bottom).offset(16)
            
        }
        
    }
}
