//
//  ViewControllerWithSideMenu.swift
//  sideMenu
//
//  Created by Nicolas Barbara on 2/17/19.
//  Copyright © 2019 Nicolas Barbara. All rights reserved.
//

import UIKit
class ViewControllerWithSideMenu:UIViewController,UIScrollViewDelegate{
    var menuViewController:MenuViewController
    var mainNavigationController:MainNavigationController
    var isMenuShowing:Bool = false
    var menuViewWidth:CGFloat
    var closeButton:UIButton?
    var isScrollEnabel:Bool
    var isCloseWhenToucheOutside:Bool
    init(menuViewController:MenuViewController,mainNavigationController:MainNavigationController,menuViewWidth:CGFloat,isScrollEnabel:Bool,isCloseWhenToucheOutside:Bool) {
        self.isCloseWhenToucheOutside = isCloseWhenToucheOutside
        self.menuViewController = menuViewController
        self.mainNavigationController = mainNavigationController
        self.menuViewWidth = menuViewWidth
        self.isScrollEnabel = isScrollEnabel
        super.init(nibName: nil, bundle: nil)
        menuViewController.viewControllerWithSideMenu = self
        mainNavigationController.viewControllerWithSideMenu = self
        scrollView.isScrollEnabled = isScrollEnabel
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isCloseWhenToucheOutside{
            if closeButton == nil{
                closeButton  = {
                    let b = UIButton()
                    b.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    b.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
                    b.alpha = 0
                    return b
                }()
                mainNavigationController.view.addSubview(closeButton!)
                closeButton?.translatesAutoresizingMaskIntoConstraints = false
                closeButton?.topAnchor.constraint(equalTo: mainNavigationController.view.topAnchor).isActive = true
                closeButton?.bottomAnchor.constraint(equalTo: mainNavigationController.view.bottomAnchor).isActive = true
                closeButton?.leftAnchor.constraint(equalTo: mainNavigationController.view.leftAnchor).isActive = true
                closeButton?.rightAnchor.constraint(equalTo: mainNavigationController.view.rightAnchor).isActive = true
            }
        }
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        if targetContentOffset.pointee.x == 0{
            isMenuShowing = true
        }
        else if targetContentOffset.pointee.x == menuViewWidth{
            isMenuShowing = false
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = 1 - (scrollView.contentOffset.x / menuViewWidth)
        closeButton?.alpha = alpha
    }
    var mainViewWithAnchor:NSLayoutConstraint!
    let scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(mainNavigationController)
        addChildViewController(menuViewController)
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(menuViewController.view)
        scrollView.addSubview(mainNavigationController.view)
        scrollView.delegate = self
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        menuViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuViewController.view.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        menuViewController.view.widthAnchor.constraint(equalToConstant: menuViewWidth).isActive = true
        mainNavigationController.view.translatesAutoresizingMaskIntoConstraints = false
        mainNavigationController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainNavigationController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainNavigationController.view.leftAnchor.constraint(equalTo: menuViewController.view.rightAnchor).isActive = true
        mainNavigationController.view.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        mainViewWithAnchor = mainNavigationController.view.widthAnchor.constraint(equalToConstant: view.frame.width)
        mainViewWithAnchor.isActive = true
        scrollView.contentOffset.x = menuViewWidth
        scrollView.contentSize.width = view.frame.width + menuViewWidth
    }
    func showMenu(){
        isMenuShowing = true
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    func hideMenu(){
        isMenuShowing = false
        scrollView.setContentOffset(CGPoint(x: menuViewWidth, y: 0), animated: true)
    }
    @objc func toggleMenu(){
        if isMenuShowing{
            hideMenu()
        }
        else{
            showMenu()
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        mainViewWithAnchor.constant = size.width
        if !isMenuShowing{
            view.isHidden = true
            coordinator.animate(alongsideTransition: nil, completion: {
                [weak self]  _ in
                guard let MySelf = self else{return}
                MySelf.isMenuShowing = false
                MySelf.scrollView.setContentOffset(CGPoint(x: MySelf.menuViewWidth, y: 0), animated: false)
                MySelf.view.isHidden = false
            })
        }
    }
}
class MenuViewController:UIViewController{
    weak var viewControllerWithSideMenu:ViewControllerWithSideMenu?
}
class MainNavigationController:UINavigationController{
    weak var viewControllerWithSideMenu:ViewControllerWithSideMenu?
}
