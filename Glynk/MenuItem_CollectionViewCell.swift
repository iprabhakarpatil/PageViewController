//
//  MenuItem_CollectionViewCell.swift
//  Glynk
//
//  Created by Prabhakar Mac on 12/17/17.
//  Copyright © 2017 prabhakar. All rights reserved.
//

import UIKit

protocol ReusableCell {

    static var defaultCellIdentifier: String { get }
}

protocol ButtonCellDelegate: class {
    func didPress (button: UIButton, for cell: UICollectionViewCell)
}

class MenuItemCell: UICollectionViewCell, ReusableCell {

    @IBOutlet private weak var titleButton: UIButton!

    weak var delegate: ButtonCellDelegate?

    /// Button Click Handler
    ///
    /// - Parameter sender: The button
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.didPress(button: sender, for: self)
    }

    var menuTitle: String = "" {
        didSet {
            titleButton.setTitle(menuTitle, for: .normal)
        }
    }

    var isMenuSelected: Bool = false {
        didSet {
            titleButton.titleLabel?.font = isMenuSelected ? UIFont.boldSystemFont(ofSize: 12) : UIFont.systemFont(ofSize: 10)
            titleButton.setTitleColor(isMenuSelected ? UIColor.magenta : UIColor.white, for: .normal)
        }
    }

    static var defaultCellIdentifier: String { return "MenuItemCell" }
}


