//
//  Controller+Extension.swift
//  PeepDesignSystemComponents
//
//  Created by Rhullian Damião on 13/03/22.
//

import Foundation
import UIKit

extension UIViewController {
    func removeBlackBar() {
        self.navigationController?.edgesForExtendedLayout = .all
        self.navigationController?.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .all
        self.extendedLayoutIncludesOpaqueBars = true
        
        if #available(iOS 13.0, *) {
            let appearence = UINavigationBarAppearance()
            appearence.backgroundColor = .white
            self.navigationController?.navigationBar.standardAppearance = appearence
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearence
        }
    }
}
