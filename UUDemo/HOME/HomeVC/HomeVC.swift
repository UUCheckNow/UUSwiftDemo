//
//  HomeVC.swift
//  UUDemo
//
//  Created by lhn on 16/11/2.
//  Copyright © 2016年 UUU. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire
import SVProgressHUD


class HomeVC: UIViewController , UITableViewDataSource, UITableViewDelegate{
    // UU_Mark:数据源数组
    var uuListArray:Array<UUModel> = []
    // UU_Mark:数据请求相关
    let defaultReqDataQuantity:Int = 20
    var currentpage:Int = 1
    
    //MARK: 控件区
    var _tableView:UITableView!
    weak var loadingView:LoadingView!
    //MARK: cell 标识符
    let CellIdentifierNib = "HomeTabCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "i"
        
        self.setTableView()

    }
    override func viewWillAppear(_ animated: Bool) {
        _tableView.mj_header.beginRefreshing()
    }
    
    //设置tableview
    func setTableView() -> Void{
        let rect:CGRect = kScreenBounds
        _tableView = UITableView(frame: rect,style: .grouped)
        _tableView!.dataSource = self
        _tableView!.delegate = self
        self.view.addSubview(_tableView!)
        
        _tableView.tableFooterView = UIView()
        
        _tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.requestUUData(isPullLoad: true, page: 1)
            
        })
        
        _tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            
            self.requestUUData(isPullLoad: false, page: self.currentpage + 1)
            
        })
        
        _tableView.mj_header.beginRefreshing()
        
        ////        Nib
        _tableView.register(UINib(nibName:"HomeTabCell",bundle: nil), forCellReuseIdentifier: CellIdentifierNib)
    }
    
    //定义的请求数据函数
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
        //展示加载动画view
        let loadingView = LoadingView.showLoadingWith(view: view)
        self.loadingView = loadingView
        
        UUDataRequest.requestData(urlStr: "http://japi.juhe.cn/joke/content/list.from", parmas: parma) { (responseObject) in
            
            print(responseObject)
            
            if isPullLoad {
                self.uuListArray.removeAll()
                self._tableView.mj_header.endRefreshing()
            }else{
                self._tableView.mj_footer.endRefreshing()
                self.currentpage = self.currentpage + 1
            }
            
            switch responseObject.result {
            case .success( _):
                if let jsonResult = responseObject.result.value as? [String: Any] {
//                    print(jsonResult)
                    if jsonResult["reason"] as? String == "Success" {
                        let jsonResult:[String: AnyObject] = jsonResult["result"] as! [String: AnyObject]
                        let listArr:Array<NSDictionary> = jsonResult["data"] as! Array<NSDictionary>
                        for objectDic in listArr
                        {
//                            print(objectDic)
                            let uu = UUModel()
                            uu.content = objectDic.object(forKey: "content") as! String
                            uu.updateTime = objectDic.object(forKey: "updatetime") as! String
                            uu.unixTime = objectDic.object(forKey: "unixtime") as! TimeInterval
                            
                            self.uuListArray.append(uu)
                        }
                        SVProgressHUD.showSuccess(withStatus: "成功")
//                        print("ardefesdgtre",self.uuListArray.count)
                        self._tableView.reloadData()
                    }else{
                        if jsonResult["error_code"] as? String != "0"
                        {
                            print("请求错误\(jsonResult["trsult"])")
                            SVProgressHUD.showError(withStatus:"请求错误\(jsonResult["trsult"])")
                        }
                        else
                        {
                            print("暂无数据，请稍后再试")
                            SVProgressHUD.showError(withStatus:"暂无数据，请稍后再试")
                        }
                    }
                }
                break
            case .failure(let Error):
                print("请求失败\(Error.localizedDescription)")
                SVProgressHUD.showError(withStatus:"请求失败\(Error.localizedDescription)")
                break
            }
            //隐藏加载动画view
            loadingView.hideLoadingView()
        }

    }
// UU_Mark:tableview相关协议
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uuListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Nib注册, 调用的时候会调用自定义cell中的  awakeFromNib  方法
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTabCell", for: indexPath) as! HomeTabCell
            cell.setData(uu: uuListArray[indexPath.row])
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 21.5 + UUUtils.getTextHeight(textStr: uuListArray[indexPath.row].content, font: UIFont.init(name: "PingFangTC-Regular", size: 25)!, labWidth: kScreenWidth - 16)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) 行")
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
