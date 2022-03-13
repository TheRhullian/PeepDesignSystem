//
//  TextfieldViewController.swift
//  4PeepDesignSystem
//
//  Created by Rhullian Damião on 13/03/22.
//

import UIKit
import PeepDesignSystem

class TextfieldViewController: UIViewController {
    override func viewDidLoad() {
        setupLayout()
        title = "Textfields"
    }
    
    func setupLayout() {
        self.removeBlackBar()
        self.view.backgroundColor = .white
    }
}
