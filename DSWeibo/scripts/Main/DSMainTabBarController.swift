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
        
        addChildViewController(DSHomeTableViewController(),title: "首页",imageName: "tabbar_home");
        addChildViewController(DSMessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(DSDiscoverTableViewController(), title:"广场", imageName: "tabbar_discover")
        addChildViewController(DSProfileTableViewController(), title: "我", imageName: "tabbar_profile");
    }

    override func didReceiveMemoryWarning() {        super.didReceiveMemoryWarning()    }
    
     /** 添加 视图  */
    private func addChildViewController(childerController:UIViewController,title:String,imageName:String){
    
        childerController.tabBarItem.image=UIImage(named:imageName);
        childerController.tabBarItem.selectedImage=UIImage(named: imageName+"_highlighted")
        childerController.title=title;
        
        let nav = UINavigationController();
        nav.addChildViewController(childerController);
        
        //uitabBarController add 一个Nav  ,nav中add一个homeTable
        addChildViewController(nav);
    }


}































