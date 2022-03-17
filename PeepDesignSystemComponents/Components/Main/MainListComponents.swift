//
//  MainListComponents.swift
//  PeepDesignSystemComponents
//
//  Created by Rhullian Damião on 13/03/22.
//

import UIKit

enum MainListComponents: CaseIterable {
    case textfield
    case button
    
    var viewController: UIViewController {
        switch self {
        case .textfield: return TextfieldViewController()
        case .button: return ButtonViewController()
        }
    }
    
    var sectionTitle: String {
        switch self {
        case .textfield: return "Campos de Texto"
        case .button: return "Botões"
        }
    }
}
