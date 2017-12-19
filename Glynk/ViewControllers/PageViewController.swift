//
//  PageViewController.swift
//  Glynk
//
//  Created by Prabhakar Mac on 12/18/17.
//  Copyright © 2017 prabhakar. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, PageController {
    
    weak var pageContainer: PagedContainer!
    var pagedMenu: PagedMenu?
    
    private (set) var currentViewController: UIViewController?
    
    private(set) lazy var viewControllerArray: [UIViewController] = {
        return [self.viewControllerToDisplay(viewControllerIdentifier: "TrendingNearYou"),
                self.viewControllerToDisplay(viewControllerIdentifier: "EventsNearYou"),
                self.viewControllerToDisplay(viewControllerIdentifier: "Politics"),
                self.viewControllerToDisplay(viewControllerIdentifier: "Technology"),
                self.viewControllerToDisplay(viewControllerIdentifier: "Sports"),
                self.viewControllerToDisplay(viewControllerIdentifier: "Music"),
                self.viewControllerToDisplay(viewControllerIdentifier: "Movies")]
    }()
    
    private (set) var currentMenuIndex: Int = 0

    // MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstVCToDisplay = viewControllerArray.first {
            setViewControllers([firstVCToDisplay],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        delegate = self
    }

    /// Instantiates the viewcontroller in order to display on the pageview.
    ///
    /// - Parameter viewControllerIdentifier: Identifier of the viewController to instantiate
    /// - Returns: UIViewController
    private func viewControllerToDisplay(viewControllerIdentifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(viewControllerIdentifier)")
    }
}

// MARK: - UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerArray.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard viewControllerArray.count > previousIndex else {
            return nil
        }
        
        return viewControllerArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerArray.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = viewControllerArray.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return viewControllerArray[nextIndex]
    }
}

// MARK: - UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if(completed) {
            if let viewController = pageViewController.viewControllers?.last {
                let index = viewControllerArray.index(of: viewController)! as! Int
                pageContainer.didMoveToPage(at: index)
            }
        }
    }
}

// MARK: - PagedMenu Delegate
extension PageViewController: PagedMenu {

    func moveToPage(at index: Int) {
        self.setViewControllers([viewControllerArray[index]], direction: .forward, animated: true, completion: nil)
    }
}
