//
//  MyMenuViewController.swift
//  sideMenu
//
//  Created by Nicolas Barbara on 2/17/19.
//  Copyright © 2019 Nicolas Barbara. All rights reserved.
//

import UIKit
class MyMenuViewController:MenuViewController,UITableViewDelegate,UITableViewDataSource{
    var list = ["White","Red","Blue"]
    var whiteViewController:WhiteViewController!
    var redViewController:RedViewController!
    var blueViewContrller:BlueViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        whiteViewController = viewControllerWithSideMenu?.mainNavigationController.visibleViewController as! WhiteViewController!
        redViewController = RedViewController()
        blueViewContrller = BlueViewController()
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:viewControllerWithSideMenu?.mainNavigationController.setViewControllers([whiteViewController], animated: false)
        case 1:viewControllerWithSideMenu?.mainNavigationController.setViewControllers([redViewController], animated: false)
        case 2:viewControllerWithSideMenu?.mainNavigationController.setViewControllers([blueViewContrller], animated: false)
        default:
            break
        }
        viewControllerWithSideMenu?.toggleMenu()
    }
}
