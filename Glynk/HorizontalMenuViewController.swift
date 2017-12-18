//
//  HorizontalMenuViewController.swift
//  Glynk
//
//  Created by Prabhakar Mac on 12/17/17.
//  Copyright © 2017 prabhakar. All rights reserved.
//

import UIKit

class HorizontalMenuViewController: UIViewController, PagedMenu {

    @IBOutlet private weak var collectionView: UICollectionView!

    private var menuItemsArray = ["Trending Near You", "Events Near You", "Politics", "Technology", "Sports", "Music", "Movies"]

    private (set) var currentMenuIndex: Int = 0

    weak var pageContainer: PagedContainer!
     var pagedMenu: PagedMenu!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Loaded  HorizontalMenuViewController")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func moveToPage(at index: Int) {
        let prevIndex = currentMenuIndex
        currentMenuIndex = index
        let indexPath = IndexPath.init(item: currentMenuIndex, section: 0)

        if prevIndex < 0 || prevIndex == currentMenuIndex {
            collectionView.reloadItems(at: [indexPath])
        } else {
            collectionView.reloadItems(at: [indexPath, IndexPath.init(item: prevIndex, section: 0)])
        }
        perform(#selector(self.scrollToSelected), with: nil, afterDelay: 0.1)
    }

    @objc func scrollToSelected () {
        let indexPath = IndexPath.init(item: currentMenuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
    }
}


// MARK: - UICollectionViewDataSource
extension HorizontalMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItemsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.defaultCellIdentifier, for: indexPath) as! MenuItemCell
        cell.delegate = self
        cell.menuTitle = menuItemsArray [indexPath.item]
        cell.isMenuSelected = indexPath.item == currentMenuIndex
        return cell
    }
}

// MARK: - ButtonCellDelegate
extension HorizontalMenuViewController: ButtonCellDelegate {

    func didPress(button: UIButton, for cell: UICollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            let prevIndex = currentMenuIndex
            currentMenuIndex = indexPath.item
            if prevIndex < 0 || prevIndex == currentMenuIndex {
                collectionView.reloadItems(at: [indexPath])
            } else {
                collectionView.reloadItems(at: [indexPath, IndexPath.init(item: prevIndex, section: indexPath.section)])
            }
            pageContainer.didSelectMenu(at: currentMenuIndex)
            pagedMenu.moveToPage(at: currentMenuIndex)

        }
    }
}
