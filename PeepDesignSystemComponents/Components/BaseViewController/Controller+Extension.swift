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
    }
}
