//
//  HomeTableViewController.swift
//  小峰微博
//
//  Created by Student on 17/9/13.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit
let StatusCellNormalId = "StatusCellNormalId"
let StatusCellRetweetedId = "StatusCellRetweetedId"
class HomeTableViewController: VisitorTableViewController {
<<<<<<< HEAD
    public lazy var listViewModel=StatusListViewModel()
    
    public lazy var pullupView:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.whiteLarge)
        indicator.color = UIColor.lightGray
        return indicator
    }()
    
    public lazy var pulldownTipLabel:UILabel = {
        let label = UILabel(title:"",fontSize:18,color:UIColor.white)
        label.backgroundColor = UIColor.orange
        self.navigationController?.navigationBar.insertSubview(label,at:0)
        return label
    }()
    
=======
    private let StatusCellNormalId = "StatusCellNormalId"
    private lazy var listViewModel = StatusListViewModel()

>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
    override func viewDidLoad() {
        super.viewDidLoad()
        if !UserAccountViewModel.sharedUserAccount.userLogin
        {
            visitorView?.setupInfo(imageName: nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        loadData()
        prepareTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
<<<<<<< HEAD
=======
        // #warning Incomplete implementation, return the number of sections
>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< HEAD
        return listViewModel.statusList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = listViewModel.statusList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: vm.cellId, for: indexPath) as! StatusCell
        //cell.viewModel=listViewModel.statusList[indexPath.row]
        cell.viewModel = vm
        
        if indexPath.row == listViewModel.statusList.count - 1 && !pullupView.isAnimating {
            pullupView.startAnimating()
            
            loadData()
        }
        
        return cell
    }
    
    public func showPulldownTip(){
        guard let count = listViewModel.pulldownCount else{
            return
        }
        pulldownTipLabel.text = (count == 0) ? "没有新微博" : "刷新到\(count)条微博"
        let height:CGFloat = 44
        let rect = CGRect(x:0,y:0,width:view.bounds.width,height:height)
        pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: -2 * height)
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: height)
        }) { (_) -> Void in
            UIView.animate(withDuration:1.0){
                self.pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: -2 * height)
            }
        }
    }
    
    @objc public func loadData()
    {
        
        self.refreshControl?.beginRefreshing()
        
        listViewModel.loadStatus(isPulled: pullupView.isAnimating){
            (isSuccessed)->() in
            
            self.refreshControl?.endRefreshing()
            
            self.pullupView.stopAnimating()
            
            if !isSuccessed
            {
                //SVProgressHUD.showInfo(withStatus: "加载数据错误，请稍后再试")
                return
            }
            for d in self.listViewModel.statusList
            {
                print(d.description)
            }
            self.showPulldownTip()
            
            self.tableView.reloadData()
        }
        
    }
    private func prepareTableView()
    {
        tableView.register(StatusNormalCell.self, forCellReuseIdentifier: StatusCellNormalId)
        tableView.register(StatusRetweetedCell.self, forCellReuseIdentifier: StatusCellRetweetedId)
        tableView.estimatedRowHeight=400
        tableView.rowHeight=400
        tableView.separatorStyle = .none
        refreshControl = WBRefreshControl()
        //修改了
        refreshControl?.addTarget(self, action: #selector(HomeTableViewController.loadData), for: UIControlEvents.valueChanged)
        tableView.tableFooterView = pullupView
        
        
    }
}
extension HomeTableViewController
{
    override func tableView(_ tableView:UITableView,heightForRowAt indexPath:IndexPath)->CGFloat
    {
        
        
        return listViewModel.statusList[indexPath.row].rowHeight
    }
}


=======
        // #warning Incomplete implementation, return the number of rows
        return listViewModel.statusList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellNormalId, for: indexPath)
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].status.user?.screen_name
        return cell
    }
    
    public func loadData(){
        /*
        NetworkTools.sharedTools.loadStatus{
            (result,error) -> () in
            if(error != nil){
                print("错了")
                return
            }
            print(result)
        }
       */
        listViewModel.loadStatus{
            (isSuccessed) -> () in
            if !isSuccessed
            {
                return
            }
            print(self.listViewModel.statusList)
            self.tableView.reloadData()
        }
    }
    private func prepareTableView(){
        tableView.register(UITableViewCell.self,forCellReuseIdentifier:StatusCellNormalId)
    }
}
extension HomeTableViewController
{
    
}
>>>>>>> 3ae4b6a9521ce2732e21eef83b2078550ffabdf1
