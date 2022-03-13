//
//  MainListComponents.swift
//  PeepDesignSystemComponents
//
//  Created by Rhullian Damião on 13/03/22.
//

import UIKit

enum MainListComponents: CaseIterable {
    case textfield
    
    var viewController: UIViewController {
        switch self {
        case .textfield: return TextfieldViewController()
        }
    }
    
    var sectionTitle: String {
        switch self {
        case .textfield: return "Textfields"
        }
    }
}
