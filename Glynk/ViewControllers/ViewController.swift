//
//  ViewController.swift
//  Glynk
//
//  Created by Prabhakar Mac on 12/17/17.
//  Copyright © 2017 prabhakar. All rights reserved.
//

import UIKit

protocol PagableView {
    var pageContainer: PagedContainer! { get set }
}

protocol PagedMenu : PagableView {

    var currentMenuIndex: Int { get }
    func moveToPage(at index: Int)
}

protocol PagedContainer : class {

    func didSelectMenu (at index: Int)
    func didMoveToPage (at index: Int)
}

protocol PageController : PagableView {

    var currentViewController: UIViewController? { get }
    var currentMenuIndex: Int { get }
}

class ViewController: UIViewController, PagedContainer {

    @IBOutlet weak var containerView: UIView!
    weak var currentViewController: UIViewController?

    private var horizontalMenuVC_PagedMenu, pageViewControllerPagedMenu: PagedMenu!

    private var pageController: PageController!

    override func viewDidLoad() {
        super.viewDidLoad()
        horizontalMenuVC_PagedMenu = self.childViewControllers [0] as! PagedMenu
        pageViewControllerPagedMenu = self.childViewControllers[1] as! PagedMenu

        horizontalMenuVC_PagedMenu.pageContainer = self
        pageViewControllerPagedMenu.pageContainer = self
        
        pageController = self.childViewControllers [1] as! PageController
        pageController.pageContainer = self
    }

    func didSelectMenu(at index: Int) {
        print(#function)
        horizontalMenuVC_PagedMenu.moveToPage(at: index)
        pageViewControllerPagedMenu.moveToPage(at: index)
    }

    func didMoveToPage(at index: Int) {
        print(#function)
        horizontalMenuVC_PagedMenu.moveToPage(at: index)
    }
}
