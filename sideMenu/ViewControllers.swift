//
//  ViewControllers.swift
//  sideMenu
//
//  Created by Nicolas Barbara on 2/16/19.
//  Copyright © 2019 Nicolas Barbara. All rights reserved.
//

import UIKit
class WhiteViewController:UIViewController{
    weak var mainNavigationController:MainNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "White"
        mainNavigationController = navigationController as? MainNavigationController
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(onClickMenuButton))
    }
    @objc func onClickMenuButton(){
        mainNavigationController?.viewControllerWithSideMenu?.toggleMenu()
    }
}
class RedViewController:UIViewController{
    weak var mainNavigationController:MainNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Red"
        mainNavigationController = navigationController as? MainNavigationController
        view.backgroundColor = .red
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(onClickMenuButton))
    }
    @objc func onClickMenuButton(){
        mainNavigationController?.viewControllerWithSideMenu?.toggleMenu()
    }
}
class BlueViewController:UIViewController{
    weak var mainNavigationController:MainNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Blue"
        mainNavigationController = navigationController as? MainNavigationController
        view.backgroundColor = .blue
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(onClickMenuButton))
    }
    @objc func onClickMenuButton(){
        mainNavigationController?.viewControllerWithSideMenu?.toggleMenu()
    }
}
