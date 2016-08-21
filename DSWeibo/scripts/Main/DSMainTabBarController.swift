//
//  DSMainTabBarController.swift
//  DSWeibo
//
//  Created by SunSi on 16/8/21.
//  Copyright © 2016年 SunSi. All rights reserved.
//

import UIKit

class DSMainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor=UIColor.orangeColor();
        
            /**  添加tabBar 按钮 */
        addTabBarItemView();
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        // 添加加号按钮
        setupComposeBtn()
    }
    
    /**  添加tabBar 按钮 */
    private func addTabBarItemView(){
        //1.nsBundle加载   2.得到jsonData  3do catch中 解析json
        let path=NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil);
        if let jsonPath=path{
            let  jsonData = NSData(contentsOfFile:  jsonPath);
            do{
                let dictArr=try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers);
                for dict in dictArr as! [[String:String]]{
                    addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!);
                }
            }
            catch{
                print(error);
                addChildViewController("DSHomeTableViewController",title: "首页",imageName: "tabbar_home");
                addChildViewController("DSMessageTableViewController", title: "消息", imageName: "tabbar_message_center")
                addChildViewController("NullViewController", title: "", imageName: "")
                addChildViewController("DSDiscoverTableViewController", title:"广场", imageName: "tabbar_discover")
                addChildViewController("DSProfileTableViewController", title: "我", imageName: "tabbar_profile");
            }
        }
    }
    
    /** 添加加号按钮  */
    private func setupComposeBtn(){
        // 1.添加加号按钮
        tabBar.addSubview(composeBtn)//先add +号
        
        let width=UIScreen.mainScreen().bounds.size.width / CGFloat(viewControllers!.count);
        let rect=CGRect(x: 0, y: 0, width: width, height: 49);
        composeBtn.frame=CGRectOffset(rect, 2*width, 0);
    }
    
    override func didReceiveMemoryWarning() {        super.didReceiveMemoryWarning()    }
    
    /** 添加 视图 UiViewController传入方式 */
    private func addChildViewController(childerController:UIViewController,title:String,imageName:String){
        //        addChildViewController(DSProfileTableViewController(), title: "我", imageName: "tabbar_profile");
        childerController.tabBarItem.image=UIImage(named:imageName);
        childerController.tabBarItem.selectedImage=UIImage(named: imageName+"_highlighted")
        childerController.title=title;
        let nav = UINavigationController();
        nav.addChildViewController(childerController);
        //uitabBarController add 一个Nav  ,nav中add一个homeTable
        addChildViewController(nav);
    }
    
    /** 添加 视图 string传入方式 */
    private func addChildViewController(stringController: String,title:String,imageName:String) {
        let nsProjectName=NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String;//拿到项目名 字符串
        let cls:AnyClass? =     NSClassFromString(nsProjectName + "."  +  stringController);//项目名  点 类名
        let vcCls=cls as! UIViewController.Type;
        let childerController=vcCls.init()
        
        childerController.tabBarItem.image=UIImage(named:imageName);
        childerController.tabBarItem.selectedImage=UIImage(named: imageName+"_highlighted")
        childerController.title=title;
        
        let nav = UINavigationController();
        nav.addChildViewController(childerController);
        
        //uitabBarController add 一个Nav  ,nav中add一个homeTable
        addChildViewController(nav);
    }
    
    /**  懒加载 UIButton 2.button的写法*/
    private lazy var composeBtn:UIButton={
        let btn=UIButton()
        btn.setImage(UIImage(named:"tabbar_compose_icon_add"),forState:UIControlState.Normal);
        btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)

        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), forState: UIControlState.Normal);
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted);

        // 4.添加监听
        btn.addTarget(self, action: #selector(DSMainTabBarController.composeBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn;
    }()
    
    func composeBtnClick(){
        print(#function)
    }
}































