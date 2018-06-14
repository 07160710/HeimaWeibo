//
//  StatusListViewModel.swift
//  小峰微博
//
<<<<<<< HEAD
//  Created by apple on 18/4/20.
//  Copyright © 2018年 Student. All rights reserved.
//

import Foundation
import SDWebImage
class StatusListViewModel
{
    ///微博数据数组  上拉／下拉刷新
    lazy var statusList=[StatusViewModel]()//[Status]()
    
    var pulldownCount:Int?
    
    public func cacheSingleImage(dataList:[StatusViewModel],finished:@escaping (_ isSuccessed:Bool)->()){
        
        let grounp = DispatchGroup()
        
        var dataLength = 0
        
        for vm in dataList{
            if vm.thumbnailUrls?.count != 1{
                continue
            }
            let url = vm.thumbnailUrls![0]
            print("要缓存的\(url)")
            grounp.enter()
            SDWebImageManager.shared().loadImage(with: url as URL, options: [SDWebImageOptions.retryFailed,SDWebImageOptions.refreshCached], progress: nil, completed: {
                (image,data1,error,_,_,_) in
                if let img = image , let data = UIImagePNGRepresentation(img){
                    dataLength+=data.count
                }
            })
            grounp.leave()
        }
        grounp.notify(queue: DispatchQueue.main){
            finished(true)
        }
    }
    
    
    ///加载网络数据
    func loadStatus(isPulled:Bool,finished:@escaping (Bool)->())
    {
        let since_id = isPulled ? 0 : (statusList.first?.status.id ?? 0)
        
        let max_id = isPulled ? (statusList.last?.status.id ?? 0) : 0
        
        NetworkTools.sharedTools.loadStatus(since_id: since_id,max_id: max_id){
=======
//  Created by apple on 18/4/8.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit
class StatusListViewModel{
    lazy var statusList = [StatusViewModel]()
    func loadStatus(finished:@escaping (Bool) ->()){
        NetworkTools.sharedTools.loadStatus{
>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
            (result,error)->() in
            if error != nil
            {
                print("出错了")
                finished(false)
                return
            }
<<<<<<< HEAD
            let result1=result as? [String:AnyObject]
            guard let array = result1?["statuses"] as? [[String:AnyObject]] else//判断result的数据结构是否正确
=======
            let result1 = result as? [String:AnyObject]
            guard let array = result1?["statuses"] as? [[String:AnyObject]] else
>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
            {
                print("数据格式错误")
                finished(false)
                return
            }
<<<<<<< HEAD
            //遍历字典的数组，字典转模型
            //1 可变的数组
            var dataList = [StatusViewModel]()
            
            for dict in array
            {
                dataList.append(StatusViewModel(status: Status(dict:dict)))
            }
            
            self.pulldownCount = (since_id > 0) ? dataList.count : nil
            
            if max_id > 0 {
                self.statusList += dataList
            }else{
                self.statusList = dataList+self.statusList
            }
            

            
            self.cacheSingleImage(dataList: dataList,finished: finished)
            finished(true)
            
        }
    }
}

=======
            var dataList = [StatusViewModel]()
            for dict in array{
                dataList.append(StatusViewModel(status:Status(dict:dict)))
            }
            self.statusList = dataList + self.statusList
            finished(true)
        }
    }
}
>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
