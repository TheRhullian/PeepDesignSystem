//
//  View+Extensions.swift
//  4PeepDesignSystem
//
//  Created by Rhullian Damião on 13/03/22.
//

import UIKit

extension UIView {
  public func addSubviews(_ views: [UIView]) {
    views.forEach { viewItem in
      self.addSubview(viewItem)
    }
  }
  
  public func tapToDismissKeyboard() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    self.addGestureRecognizer(tap)
  }
  
  @objc
  private func dismissKeyboard() {
    self.endEditing(true)
  }
}
