//
//  TextfieldViewController.swift
//  4PeepDesignSystem
//
//  Created by Rhullian Damião on 13/03/22.
//

import UIKit
import PeepDesignSystem

class TextfieldViewController: UIViewController {
    private lazy var textfield: PeepTextfield = {
        let textfield = PeepTextfield()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        return textfield
    }()
    
    override func viewDidLoad() {
        title = "Textfields"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLayout()
    }
    
    func setupLayout() {
        self.removeBlackBar()
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = .white
        
        // Setagem do textfield
        self.view.addSubview(textfield)
        
        NSLayoutConstraint.activate([
            textfield.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -16),
            textfield.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
}
