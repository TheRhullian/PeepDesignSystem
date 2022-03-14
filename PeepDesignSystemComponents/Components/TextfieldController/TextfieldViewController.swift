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
    
    private lazy var textfieldWithMask: PeepTextfield = {
        let textfield = PeepTextfield()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.maskType = .cpf
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
        self.view.addSubviews([
            textfield,
            textfieldWithMask
        ])
        
        NSLayoutConstraint.activate([
            textfield.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -30),
            textfield.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            textfieldWithMask.heightAnchor.constraint(equalTo: textfield.heightAnchor),
            textfieldWithMask.widthAnchor.constraint(equalTo: textfield.widthAnchor),
            textfieldWithMask.centerXAnchor.constraint(equalTo: textfield.centerXAnchor),
            textfieldWithMask.topAnchor.constraint(equalTo: textfield.bottomAnchor, constant: 30)
        ])
    }
}
