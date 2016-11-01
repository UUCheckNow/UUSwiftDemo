//
//  HomeTableViewController.swift
//  UUDemo
//
//  Created by lhn on 16/11/1.
//  Copyright © 2016年 UUU. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire

class HomeTableViewController: UITableViewController {
    //在这里定义全局变量
    var uuListArray:Array<UUModel> = []
    
    let defaultReqDataQuantity:Int = 20
    var currentpage:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.tableFooterView = UIView()
        
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.requestUUData(isPullLoad: true, page: 1)
            
        })
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            
            self.requestUUData(isPullLoad: false, page: self.currentpage + 1)
            
        })
        
        self.tableView.mj_header.beginRefreshing()
    }
    //定义的刷新数据函数
    func requestUUData(isPullLoad:Bool,page:Int)
    {
        let cDate:Date = Date()
        let timeInterval = cDate.timeIntervalSince1970
        let timeStr = String(format:"%.f",timeInterval)
        
        let parma:[String:Any] = ["sort":"desc",
                                  "page":page,
                                  "pagesize":defaultReqDataQuantity,
                                  "time":timeStr,
                                  "key":"b97a9a346772e6727b0eecc1d52f03a1"
        ]
        
        UUDataRequest.requestData(urlStr: "http://japi.juhe.cn/joke/content/list.from", parmas: parma) { (responseObject) in
            
            print(responseObject)
            
            if isPullLoad {
                self.uuListArray.removeAll()
                self.tableView.mj_header.endRefreshing()
            }else{
                self.tableView.mj_footer.endRefreshing()
                self.currentpage = self.currentpage + 1
            }
            
            switch responseObject.result {
            case .success( _):
                if let jsonResult = responseObject.result.value as? [String: Any] {
                    print(jsonResult)
                    if jsonResult["reason"] as? String == "Success" {
                        let jsonResult:[String: AnyObject] = jsonResult["result"] as! [String: AnyObject]
                        let listArr:Array<NSDictionary> = jsonResult["data"] as! Array<NSDictionary>
                        for objectDic in listArr
                        {
                            print(objectDic)
                            let uu = UUModel()
                            uu.content = objectDic.object(forKey: "content") as! String
                            uu.updateTime = objectDic.object(forKey: "updatetime") as! String
                            uu.unixTime = objectDic.object(forKey: "unixtime") as! TimeInterval
                            
                            self.uuListArray.append(uu)
                        }
                        self.tableView.reloadData()
                    }else{
                        if jsonResult["error_code"] as? String != "0"
                        {
                            print("请求错误\(jsonResult["trsult"])")
                        }
                        else
                        {
                            print("暂无数据，请稍后再试")
                        }
                    }
                }
                break
            case .failure(let Error):
                print("请求失败\(Error.localizedDescription)")
                break
            }
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return uuListArray.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "UUTableViewCell", for: indexPath) as! UUTableViewCell
     
     // Configure the cell...
     cell.selectionStyle = .none
        cell.setData(uu: uuListArray[indexPath.row])
     return cell
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 21.5 + UUUtils.getTextHeight(textStr: uuListArray[indexPath.row].content, font: UIFont.init(name: "PingFangTC-Regular", size: 25)!, labWidth: kScreenWidth - 16);
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
 
    
}
