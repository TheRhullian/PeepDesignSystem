//
//  MainListComponents.swift
//  CEAUIKitComponents
//
//  Created by Rhullian Damião on 09/06/21.
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
        case .textfield: return "CEATextfields"
        }
    }
}
